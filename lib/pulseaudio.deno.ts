const PA_LIST_RE = /^([\w\s]+) #(\d+)$/;

export enum PactlDeviceState {
  Idle = "IDLE",
  Running = "RUNNING",
  Suspended = "SUSPENDED",
}

export enum PactlDeviceType {
  Card = "Card",
  Client = "Client",
  Module = "Module",
  Sample = "Sample",
  Sink = "Sink",
  SinkInput = "Sink Input",
  Source = "Source",
  SourceOutput = "Source Output",
}

export function parsePactlList(text: string): PactlDevice[] {
  const result = [];

  let device = makePactlDevice(PactlDeviceType.Module, 0);
  for (let line of text.split("\n")) {
    line = line.trim();

    let [, deviceType, deviceNumber] = line.match(PA_LIST_RE) || [];
    if (deviceType && deviceNumber) {
      device = makePactlDevice(
        castPactlDeviceType(deviceType),
        parseInt(deviceNumber, 10),
      );
      result.push(device);
    }

    if (typeof device === "undefined") {
      continue;
    }

    let [attributeKey, attributeValue] = line.split(": ");
    switch (attributeKey) {
      case "Description":
        device.description = attributeValue;
        break;
      case "State":
        device.state = castPactlDeviceState(attributeValue);
        break;
      case "Name":
        device.name = attributeValue;
        break;
    }
  }

  return result;
}

interface PactlDevice {
  description: string;
  deviceNumber: number;
  deviceType: PactlDeviceType;
  name: string;
  state: PactlDeviceState;
}

function castPactlDeviceState(value: unknown): PactlDeviceState {
  if (Object.values(PactlDeviceState).includes(value as PactlDeviceState)) {
    return value as PactlDeviceState;
  }
  throw new TypeError(`"${value}" is not a valid pulseaudio device state`);
}

function castPactlDeviceType(value: unknown): PactlDeviceType {
  if (Object.values(PactlDeviceType).includes(value as PactlDeviceType)) {
    return value as PactlDeviceType;
  }
  throw new TypeError(`"${value}" is not a valid pulseaudio device type`);
}

function makePactlDevice(
  deviceType: PactlDeviceType,
  deviceNumber: number,
): PactlDevice {
  return {
    description: "",
    deviceNumber: deviceNumber,
    deviceType: deviceType,
    name: "",
    state: PactlDeviceState.Running,
  };
}
