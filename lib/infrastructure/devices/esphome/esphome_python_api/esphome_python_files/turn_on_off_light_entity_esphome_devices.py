import sys

import aioesphomeapi
import asyncio


async def main():

    if len(sys.argv) < 6:
        print('Not enough arguments')
        await result_in_new_massage()
        print('Error 1')
        exit(1)
    device_address = sys.argv[1]
    device_port = int(sys.argv[2])
    device_password = sys.argv[3]

    device_key = int(sys.argv[4])

    device_new_state = True
    if "false" == sys.argv[5].lower() or "0" == sys.argv[5]:
        device_new_state = False

    # Establish connection
    api = aioesphomeapi.APIClient(device_address, device_port, device_password)
    await api.connect(login=True)
    await api.light_command(device_key, device_new_state)


async def result_in_new_massage():
    await asyncio.sleep(0.0001)

loop = asyncio.get_event_loop()
loop.run_until_complete(main())
