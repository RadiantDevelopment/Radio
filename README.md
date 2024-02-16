# A FiveM Radio resource brough to you by Radiant using the React UI Framework.

This is a simple Radio resource made by @justcallme2k that is supposed to replace the default 'qb-radio' resource with the core functionality of bringing a smooth experience for the user.

```onResourceStart``` All players will be disconnected from their radios.

```Radio.sendReactMessage(action, data) ``` Will send a react message with an action and some data.

```Radio.setFrequency(frequency)``` Sets the player's current radio frequency. 

```Radio.open``` Triggers a React message to open the Radio.

```Radio.close``` Triggers a React message to close the Radio.

```RegisterKeyMapping("+openRadio", "Open Radio", "keyboard", "")``` Default Radio open keybind is ```o```.


## NUI Callbacks
```Radio:Close``` Utilizes ```Radio.close```

```Radio:setPower``` Sets the radio's power state (boolean).

```Radio:setFrequency``` Sets the player's radio frequency (number).


## Previews
![](https://i.imgur.com/kQrqD1Y.jpeg)
![](https://i.imgur.com/fym4LtF.jpeg)
![](https://i.imgur.com/SRmYfjD.jpeg)


#### Thank you for choosing Radiant. 

To receive updates, join our Discord @ dsc.gg/radiantdevelopment.
