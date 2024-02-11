import json
import sys


def get_all_room_keys(redis_key: str):
    """
        Returns un-decoded json strings

    """
    # Load data from the JSON file
    with open('backup.json', 'r') as file:
        data = json.load(file)

    return_set = []
    for item in data:
        if item['redis_key'].startswith(redis_key):
            return_set.append(item['redis_value_object'])
    
    return return_set


def lambda_handler(event, context):

    try:
        # Your function logic here
        # Extract parameters from the Lambda event object
        device_id = event.get('device_id')
        version = event.get('version')
        channel = event.get('channel')
        room = event.get('room')
        nardi = event.get('nardi')


        room_data = get_room_data(device_id, version, channel, room, nardi)

        return {
            'statusCode': 200,
            'body': json.dumps(room_data)
        }

    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps('An error occurred' + str(e))
        }



def get_room_data(device_id, version, channel, room, nardi):
    redis_key = f"{version}:{channel}:{room}"

    print(redis_key)
    # ... rest of your existing get_room_data logic ...
    lines_of_text = get_all_room_keys(redis_key)
#    lines_of_text = [json.loads(i) for i in lines_of_text]
    lines_of_text = sorted(lines_of_text, key=lambda x: x.get('slot_id'))
    room_flags = []
    # strip device id
    # and replace with is_owner
    for row in lines_of_text:
        row["is_owner"] = False
        # self._logger.info("Line of stuff: %s", row)
        if 'device_id' in row:
            if row["device_id"] == device_id:
                row["is_owner"] = True
            del(row["device_id"])

        if 'read_level' in row:
            row["read_level"] = int(row["read_level"])

        if 'author_level' in row:
            row["author_level"] = int(row["author_level"])

        if 'bestow_points' in row:
            row["bestow_points"] = int(row["bestow_points"])

        if 'bestow_level' in row:
            row["bestow_level"] = int(row["bestow_level"])

        if 'room_flags' in row:
            flags = row['room_flags'].split(",")
            flags = [i.strip() for i in flags]
            flags = list(set(flags))
            flags.sort()
            row["room_flags"] = flags
            room_flags.extend(flags)

        if 'bestow_room_passes' in row:
            room_passes = row['bestow_room_passes'].split(",")
            room_passes = [i.strip() for i in room_passes]
            room_passes = list(set(room_passes))
            room_passes.sort()
            row['bestow_room_passes'] = room_passes

        if 'bestow_prizes' in row:
            prizes = row['bestow_prizes'].split(",")
            prizes = [i.strip() for i in prizes]
            prizes = list(set(prizes))
            prizes.sort()
            row['bestow_prizes'] = prizes

    room_flags = list(set(room_flags))

    try:
        nardi = int(nardi)
        # LOCKED rooms are okay to get for free
        if 'LOCKED' not in room_flags:
            if nardi > 0:
                nardi -= 1
    except:
        nardi = 0

    return_data = {"status": "ok",
                   "channel": channel,
                   "room": room,
                   "nardi": nardi,
                   "version": int(version),
                   "room_flags": room_flags,
                   "lines_of_text": lines_of_text}

    return return_data


if __name__ == "__main__":
    test_event = {
        'device_id': 'WEB-APP-DEVICE',
        'version': '1',
        'channel': 'nardo',
        'room': 'AAAA',
        'nardi': 'some_value'
    }

    print(lambda_handler(test_event, None))
