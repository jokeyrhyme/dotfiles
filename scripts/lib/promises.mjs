/* eslint-env es2021 */

export function sleep(ms = 1000) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

export async function waitUntil({ fn, sleepMs, deadlineMs = 5000 } = {}) {
  const deadline = deadlineMs > 0 ? deadlineMs + Date.now() : Infinity;
  let result;
  while (!result) {
    if (Date.now() > deadline) {
      throw new Error('deadline exceeded');
    }
    try {
      result = await fn();
    } finally {
      await sleep(sleepMs);
    }
  }
}
