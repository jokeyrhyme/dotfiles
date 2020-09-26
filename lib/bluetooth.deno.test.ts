import {
  assertEquals,
  assertArrayContains,
} from "https://deno.land/std@0.70.0/testing/asserts.ts";
import {
  parseBluetoothctlInfo,
  parseBluetoothctlPairedDevices,
} from "./bluetooth.deno.ts";

Deno.test("parseBluetoothctlInfo", () => {
  const input = `
Device 00:00:00:00:00:00 (public)
        Name: Pixel Buds
        Alias: Pixel Buds
        Class: 0x00240404
        Icon: audio-card
        Paired: yes
        Trusted: yes
        Blocked: no
        Connected: no
        LegacyPairing: no
        UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
        UUID: Vendor specific           (df21fe2c-2515-4fdb-8886-f12c4d67927c)
        UUID: Vendor specific           (f8d1fbe4-7966-4334-8024-ff96c9330e15)
        Modalias: bluetooth:v02B0p0000d001F
  `;
  const expected = {
    alias: "Pixel Buds",
    blocked: false,
    class: "0x00240404",
    connected: false,
    icon: "audio-card",
    legacyPairing: false,
    mac: "00:00:00:00:00:00",
    modAlias: "bluetooth:v02B0p0000d001F",
    name: "Pixel Buds",
    paired: true,
    trusted: true,
    uuids: [
      {
        type: "Audio Sink",
        uuid: "0000110b-0000-1000-8000-00805f9b34fb",
      },
      {
        type: "Vendor specific",
        uuid: "df21fe2c-2515-4fdb-8886-f12c4d67927c",
      },
      {
        type: "Vendor specific",
        uuid: "f8d1fbe4-7966-4334-8024-ff96c9330e15",
      },
    ],
  };
  const got = parseBluetoothctlInfo(input);

  assertEquals(expected, got);
});

Deno.test("parseBluetoothctlPairedDevices", () => {
  const input = `
Device 00:00:00:00:00:00 Something
Device 00:00:00:00:00:01 Something Else
Device 00:00:00:00:00:02 Another Thing
  `;
  const expected = [
    { mac: "00:00:00:00:00:00", name: "Something" },
    { mac: "00:00:00:00:00:01", name: "Something Else" },
    { mac: "00:00:00:00:00:02", name: "Another Thing" },
  ];
  const got = parseBluetoothctlPairedDevices(input);

  assertArrayContains(expected, got);
  assertEquals(expected.length, got.length);
});
