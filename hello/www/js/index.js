/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

// Wait for the deviceready event before using any of Cordova's device APIs.
// See https://cordova.apache.org/docs/en/latest/cordova/events/events.html#deviceready
document.addEventListener('deviceready', function () {
    console.log('=========================')
    cordova.plugins.backgroundMode.enable();
    onDeviceReady()
    //    setInterval(()=>{
    //        if(send ){
    //            publishMessage()
    //        }
    //    },8000)
}, false);
function onDeviceReady() {
    // Cordova is now initialized. Have fun!
    
    //  parameter sequence  (publishKeys, subcriptionKey, channelName, authKey)
    window.cordova.plugins.pubNubios.coolMethod(["pub-c-011fbf59-31e8-45f4-8e94-9feb817a3ee0",
                                                 "sub-c-e3821d24-0458-11eb-ac24-4e38869d876d", "awesomeChannel",
                                                 "sec-c-MjNlNzFkNWMtMWU4Ni00N2MyLTliZmEtMGRhZGZhNGMxZmFl"],(s)=>{
        document.getElementById('deviceready').textContent = `+--+++${s}`;
        s = JSON.parse(s);
        console.log(s);
        if(s && s.message.content)
        {
            publishMessage(s.message.content)
        } else if(s && s.publisher)
        {
            //            publishMessage(s.message)
        }
        else if(s && s.channel)
        {
            //            publishMessage(s.message)
        }
        
        else if(s && s.subscription)
        {
            //            publishMessage(s.message)
        }
        
        else if(s && s.subscription)
        {
            //            publishMessage(s.message)
        }
        
        else if(s && s.timetoken)
        {
            //            publishMessage(s.message)
        }
        
    },
                                                (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
    
    console.log('Running cordova-' + cordova.platformId + '@' + cordova.version);
    document.getElementById('deviceready').classList.add('ready');
}



function pubNubGlobalHereNow(){
    window.cordova.plugins.pubNubios.pubNubGlobalHereNow(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                         (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameter (message)

function publishMessage(message= null){
    window.cordova.plugins.pubNubios.publishMessage([message?message:`testArg ${new Date().toISOString()}`],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                    (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

//  parameter(channel name)

function removeChannelsMetaData(){
    window.cordova.plugins.pubNubios.removeChannelsMetaData(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                            (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameter (topicOfBundelIdentifier)

function removeAllPushNotification(){
    window.cordova.plugins.pubNubios.removeAllPushNotification(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                               (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameters (channelNames, topicOfBundelIdentifier)

function enablePushNotification(){
    window.cordova.plugins.pubNubios.enablePushNotification(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                            (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameters (channelName)

function pushNotificationOnChammel(){
    window.cordova.plugins.pubNubios.pushNotificationOnChammel(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                               (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}


// parameters (channelName, timeToken)

function messgaeCount(){
    window.cordova.plugins.pubNubios.messgaeCount(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                  (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}


// parameters (channelName, timeTokenStart, timeTokenEnd)

function deleteMessageFromChannel(){
    window.cordova.plugins.pubNubios.deleteMessageFromChannel(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                              (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameter (channelName)

function historyOfLastThreeMessage(){
    window.cordova.plugins.pubNubios.historyOfLastThreeMessage(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                               (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameter (channelName)

function historyOfChannel(){
    window.cordova.plugins.pubNubios.historyOfChannel(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                      (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}


function listOfSubcribedUdid(){
    window.cordova.plugins.pubNubios.listOfSubcribedUdid(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                         (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameters (channelsNmae)

function listOfUdidFromChannel(){
    window.cordova.plugins.pubNubios.listOfUdidFromChannel(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                           (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}


// parameters (channelsName, keys, value)

function signal(){
    window.cordova.plugins.pubNubios.signal(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                            (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameters(channelsName, keys, message)

function sendMessageWithCompression(){
    window.cordova.plugins.pubNubios.sendMessageWithCompression(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                                (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameters(channelsName, timeToken, Type, value)

function addMessageAction(){
    window.cordova.plugins.pubNubios.addMessageAction(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                      (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

function pubNubWhereNow(){
    window.cordova.plugins.pubNubios.addMessageAction(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                      (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

function pubNubGlobalHereNow(){
    window.cordova.plugins.pubNubios.pubNubGlobalHereNow(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                         (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}


// parameters (channelsName)

function pubNubHereNowForChannel(){
    window.cordova.plugins.pubNubios.pubNubHereNowForChannel(['awesomeChannel'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                             (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameter(channelsName)

function pubNubSubscribeToPresence(){
    window.cordova.plugins.pubNubios.pubNubSubscribeToPresence(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                               (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}

// parameter(channelsName)

function pubNubUnsubFromPresence(){
    window.cordova.plugins.pubNubios.pubNubUnsubFromPresence(['testArg'],(s)=>{
        document.getElementById('deviceready').textContent = `++++${s}`;
        console.log(s);
    },
                                                             (e)=>{
        document.getElementById('deviceready').textContent = `====${s}`;
        console.log(e)
    })
}






