import { MutableRefObject, useEffect, useRef } from "react";

// 
// DEBUG DATA
// 

interface DebugEvent<T = any> {
    action: string;
    data: T;
}

export const debugData = <P>(events: DebugEvent<P>[], timer = 1000): void => {
    if (import.meta.env.MODE === "development" && isEnvBrowser()) {
        for (const event of events) {
            setTimeout(() => {
                window.dispatchEvent(
                    new MessageEvent("message", {
                        data: {
                            action: event.action,
                            data: event.data,
                        },
                    })
                );
            }, timer);
        }
    }
};


// 
// fetchNui
// 

export async function fetchNui<T = any>(
	eventName: string,
	data?: any,
	mockData?: T
): Promise<T> {
	const options = {
		method: "post",
		headers: {
			"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify(data),
	};

	if (isEnvBrowser() && mockData) return mockData;

	const resourceName = (window as any).GetParentResourceName
		? (window as any).GetParentResourceName()
		: "nui-frame-app";

	const resp = await fetch(`https://${resourceName}/${eventName}`, options);

	const respFormatted = await resp.json();

	return respFormatted;
}


// 
// Miscellaneous
// 

export const isEnvBrowser = (): boolean => !(window as any).invokeNative;
export const noOperationFunction = () => {};


// 
// useNuiEvent
// 

interface NuiMessageData<T = unknown> {
	action: string;
	data: T;
}

type NuiHandlerSignature<T> = (data: T) => void;

export const useNuiEvent = <T = any>(
	action: string,
	handler: (data: T) => void
) => {
	const savedHandler: MutableRefObject<NuiHandlerSignature<T>> = useRef(() => {});

	// Make sure we handle for a reactive handler
	useEffect(() => {
		savedHandler.current = handler;
	}, [handler]);

	useEffect(() => {
		const eventListener = (event: MessageEvent<NuiMessageData<T>>) => {
			const { action: eventAction, data } = event.data;

			if (savedHandler.current) {
				if (eventAction === action) {
					savedHandler.current(data);
				}
			}
		};

		window.addEventListener("message", eventListener);
        
        return () => {
            window.removeEventListener("message", eventListener);
        }
	}, [action]);
};
