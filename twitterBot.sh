import tweepy
import time
print('TwitterBot', flush=True)

auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
auth.set_access_token(ACCESS_KEY, ACCESS_SECRET)
api = tweepy.API(auth)

FILE_NAME = 'last_seenid.txt'

def retrieve_last_seen_id(file_name):
    f_read = open(file_name, 'r')
    last_seen_id = int(f_read.read().strip())
    f_read.close()
    return last_seen_id

def store_last_seen_id(last_seen_id, file_name):
    f_write = open(file_name, 'w')
    f_write.write(str(last_seen_id))
    f_write.close()
    return

def reply_to_tweets():
    print('retrieving and replying to tweets...', flush=True)
    last_seen_id = retrieve_last_seen_id(FILE_NAME)
    home_tline = api.home_timeline(
                        last_seen_id,
                        tweet_mode='extended')
    for hometimeline in reversed(home_tline):
        print(str(hometimeline.id) + ' - ' + hometimeline.full_text,flush=True)
        last_seen_id = hometimeline.id
        store_last_seen_id(last_seen_id, FILE_NAME)
        # Replace your word with Merry christmas as you want, because i created this to reply christmas wishes :)
        if 'Merry Christmas' in hometimeline.full_text.lower():
            print('found similar tweet', flush=True)
            print('responding back...', flush=True)
            api.update_status('@' + hometimeline.user.screen_name + 'Wish you the same !!', hometimeline.id)

while True:
    reply_to_tweets()
    time.sleep(15)
