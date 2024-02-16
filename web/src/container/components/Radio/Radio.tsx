import React, { useEffect, useState } from 'react';

import radio from "./Radio.module.less";

import { Button, Tooltip, Slide } from "@mui/material";
import { useNuiEvent, fetchNui, isEnvBrowser } from '../../Lib/FiveM';

export const Radio: React.FC = () => {
    const [Open, setOpen] = useState(false);

    const [power, setPower] = useState(false);
    const [frequency, setFrequency] = useState("");

    const Radio = {
        header: 'Radio',
        switch: 'Switch'
    }

    useEffect(() => {
        const handleKeyEvent = (e: KeyboardEvent) => {
            if (e.key === "Escape") {
                setOpen(false);
                fetchNui("Radio:Close");
            }
        };
        
        window.addEventListener("keyup", handleKeyEvent);
    }, []);

    useNuiEvent('Radio:Open', () => {
        setOpen(true);
        fetchNui('Radio:Opened')
    })

    const setPowerState = () => {
        fetchNui("Radio:setPower");
        setPower(!power);
    };

    const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        event.preventDefault();
        const freq = event.target.value;

        if (Number(freq) > 999) {
            setFrequency("999");
            return;
        }

        setFrequency(event.target.value);
    };

    return (
        <>
            {isEnvBrowser() &&
                <>
                    <Button 
                        variant='contained'
                        color='secondary'
                        style={{ fontFamily: 'Inter Medium' }}
                        onClick={() =>{
                            setOpen((prevOpen) => !prevOpen)
                        }}>
                        Toggle Radio
                    </Button>
                </>
            }

            <Slide
                direction="up"
                in={Open}
                timeout={{ 
                    enter: 400, 
                    exit: 600
                }}
            >
                <div
                    className={radio.Container}
                >
                    <Tooltip
                        title={`${Radio.switch} ${power ? "Off" : "On"}`}
                        placement="left"
                        arrow
                    >
                        <div 
                            className={radio.powerButton} 
                            onClick={setPowerState}
                        ></div>
                    </Tooltip>

                    <div className={radio.screenContainer}>
                        <div className={radio.header}>{Radio.header}</div>
                        <input 
                            className={radio.inputContainer}
                            type="number"

                            min={1}
                            max={999}
                            
                            step=".1"
                            
                            placeholder={!power ? "Off" : "100.0"}
                            
                            disabled={!power}
                            onChange={handleChange}
                            
                            value={!power ? "" : frequency}

                            onKeyDown={(e) => {
                                if (e.key === "Enter") {
                                    const target = e.target as HTMLInputElement;
                                    fetchNui("Radio:setFrequency", Number(target.value));
                                }
                            }}
                        ></input>
                    </div>
                </div>
            </Slide>
        </>
    )
}