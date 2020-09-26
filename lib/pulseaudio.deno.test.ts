import {
  assertEquals,
  assertArrayContains,
} from "https://deno.land/std@0.70.0/testing/asserts.ts";
import {
  PactlDeviceState,
  PactlDeviceType,
  parsePactlList,
} from "./pulseaudio.deno.ts";

Deno.test("parsePactlList", () => {
  const input = `
Sink #14
        State: RUNNING
        Name: bluez_sink.MAC_WITH_UNDERSCORES.a2dp_sink
        Description: Pixel Buds
        Driver: module-bluez5-device.c
        Sample Specification: s16le 2ch 48000Hz
        Channel Map: front-left,front-right
        Owner Module: 31
        Mute: no
        Volume: front-left: 65528 / 100% / -0.00 dB,   front-right: 65528 / 100% / -0.00 dB
                balance 0.00
        Base Volume: 65536 / 100% / 0.00 dB
        Monitor Source: bluez_sink.MAC_WITH_UNDERSCORES.a2dp_sink.monitor
        Latency: 243115 usec, configured 38333 usec
        Flags: HARDWARE DECIBEL_VOLUME LATENCY
        Properties:
                bluetooth.protocol = "a2dp_sink"
                device.description = "Pixel Buds"
                device.string = "MAC_WITH_COLONS"
                device.api = "bluez"
                device.class = "sound"
                device.bus = "bluetooth"
                device.form_factor = "headset"
                bluez.path = "/org/bluez/hci0/dev_MAC_WITH_UNDERSCORES"
                bluez.class = "0x240404"
                bluez.alias = "Pixel Buds"
                device.icon_name = "audio-headset-bluetooth"
                device.intended_roles = "phone"
        Ports:
                headset-output: Headset (priority: 0, available)
        Active Port: headset-output
        Formats:
                pcm
  `;
  const expected = [{
    description: "Pixel Buds",
    deviceNumber: 14,
    deviceType: PactlDeviceType.Sink,
    name: "bluez_sink.MAC_WITH_UNDERSCORES.a2dp_sink",
    state: PactlDeviceState.Running,
  }];
  const got = parsePactlList(input);

  assertArrayContains(expected, got);
  assertEquals(got.length, expected.length);
});
