#! /usr/bin/env node

'use strict';

const childProcess = require('child_process');

(async () => {
  const device = extractInternetDevice(await spawn('nmcli'));
  const status = extractStatus(await spawn('nmcli', ['general', 'status']));

  console.log(JSON.stringify({
    class: status,
    percentage: status === 'connected' ? 100 : 0,
    text: device || status,
    tooltip: `${device}: ${status}`,
  }));
})().catch((err) => console.error(err));

// example output from `nmcli`:
// DNS configuration:
//   servers: 192.168.1.1
//   interface: enp42s0 # or wlp39s0
function extractInternetDevice(input = '') {
  const [ , afterDNS = '' ] = input.split('DNS configuration:') || [];
  const lines = afterDNS.split('\n');
  for (let line of lines) {
    line = line.trim();
    const [ , device ] = line.match(/interface: (\w+)/) || [];
    if (device) {
      return device;
    }
  }
  return undefined;
}

// example output from `nmcli general status`
function extractStatus(input = '') {
  const [ , secondLine = '' ] = input.split('\n') || [];
  const [ status ] = secondLine.match(/^\w+/);
  return status || 'disconnected';
}

async function spawn(exe, args) {
  return new Promise((resolve, reject) => {
    const child = childProcess.spawn(exe, args);
    let stdout = '';
    child.stdout.on('data', (data)  => {
      stdout += data;
    });
    child.once('close', handleClose);
    child.once('error', reject);
    child.once('exit', handleClose);

    function handleClose(code) {
      if (code === 0) {
        resolve(stdout);
      } else {
        reject(new Error('non-zero exit code'));
      }
    }
  });
}
