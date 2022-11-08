import json
import sys

import aioesphomeapi
import asyncio


async def main():
    """Connect to an ESPHome device and get details."""

    if len(sys.argv) < 4:
        print('Not enough arguments')
        await result_in_new_massage()
        print('Error 1')
        exit(1)
    device_address = sys.argv[1]
    device_port = int(sys.argv[2])
    device_password = sys.argv[3]

    # Establish connection
    api = aioesphomeapi.APIClient(device_address, device_port, device_password)
    await api.connect(login=True)
    device_info = await api.device_info()

    # List all entities of the device
    entities = await api.list_entities_services()

    for entity_list in entities:
        for entity_temp in entity_list:
            type_me = type(entity_temp).__name__
            print(type_me)
            await result_in_new_massage()
            print(json.dumps(entity_temp.__dict__))
            await result_in_new_massage()
        await result_in_new_massage()


async def result_in_new_massage():
    await asyncio.sleep(2)


loop = asyncio.get_event_loop()
loop.run_until_complete(main())
