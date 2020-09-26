import { castBoolean, castMAC } from "./types.ts";

const BT_INFO_RE = /^Device ([\w:]+)/;
const BT_UUID_RE = /^(.+)\s+\(([\w-]+)\)$/; // TODO: check UUID format

export function parseBluetoothctlInfo(text: string): BluetoothctlDevice {
  const device = makeBluetoothctlDevice();
  for (let line of text.split("\n")) {
    line = line.trim();

    let [, mac] = line.match(BT_INFO_RE) || [];
    if (mac) {
      device.mac = castMAC(mac);
    }

    let [attributeKey, attributeValue] = line.split(": ");
    switch (attributeKey) {
      case "Alias":
        device.alias = attributeValue;
        break;
      case "Blocked":
        device.blocked = castBoolean(attributeValue);
        break;
      case "Class":
        device.class = attributeValue;
        break;
      case "Connected":
        device.connected = castBoolean(attributeValue);
        break;
      case "Icon":
        device.icon = attributeValue;
        break;
      case "LegacyPairing":
        device.legacyPairing = castBoolean(attributeValue);
        break;
      case "Modalias":
        device.modAlias = attributeValue;
        break;
      case "Name":
        device.name = attributeValue;
        break;
      case "Paired":
        device.paired = castBoolean(attributeValue);
        break;
      case "Trusted":
        device.trusted = castBoolean(attributeValue);
        break;
      case "UUID":
        let [, type, uuid] = attributeValue.match(BT_UUID_RE) || [];
        if (type && uuid) {
          device.uuids.push({ type: type.trim(), uuid });
        }
        break;
    }
  }

  return device;
}

interface BluetoothctlDevice {
  alias: string;
  blocked: boolean;
  class: string;
  connected: boolean;
  icon: string;
  legacyPairing: boolean;
  mac: string;
  modAlias: string;
  name: string;
  paired: boolean;
  trusted: boolean;
  uuids: BluetoothctlDeviceUUID[];
}

interface BluetoothctlDeviceUUID {
  type: string;
  uuid: string;
}

function makeBluetoothctlDevice(): BluetoothctlDevice {
  return {
    alias: "",
    blocked: false,
    class: "",
    connected: false,
    icon: "",
    legacyPairing: false,
    mac: "",
    modAlias: "",
    name: "",
    paired: false,
    trusted: false,
    uuids: [],
  };
}
