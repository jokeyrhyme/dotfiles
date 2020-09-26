const FALSE_WORDS = ["inactive", "no", "off"];
const TRUE_WORDS = ["active", "on", "yes"];
export function castBoolean(value: unknown): boolean {
  if (typeof value === "boolean") {
    return value as boolean;
  }
  if (typeof value === "string") {
    if (TRUE_WORDS.includes(value as string)) {
      return true;
    }
    if (FALSE_WORDS.includes(value as string)) {
      return false;
    }
  }
  throw new TypeError(`cannot cast "${value}" to a boolean`);
}

const MAC_RE = /^[0-9A-F]{2}(:[0-9A-F]{2}){5}$/;
// TODO: have a strict `MAC` type instead of a string
export function castMAC(value: unknown): string {
  if (typeof value === "string") {
    value = value.toUpperCase();
    if (MAC_RE.test(value as string)) {
      return value as string;
    }
  }
  throw new TypeError(`cannot cast "${value}" to a MAC address`);
}
