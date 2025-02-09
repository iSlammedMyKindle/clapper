extends Node2D
var client
var sent_intents = false
var reward_title = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var document = JavaScriptBridge.get_interface('document')
	# To prevent crashing if this isn't compiled to a web export
	if document != null:
		var searchParams = JavaScriptBridge.create_object("URL", document.URL).searchParams
		var target_ip = searchParams.get('ip')
		reward_title = searchParams.get('reward')
		
		if target_ip != null:
			JavaScriptBridge.get_interface('console').log('hi from godot!', target_ip, reward_title)
			client = WebSocketPeer.new();
			client.connect_to_url("wss://"+target_ip+":9001")

func _process(_delta):
	if client == null:
		return;

	# Copied/pasted lines from the kindle avatar code to connect to TLC
	client.poll()
	var currState = client.get_ready_state()
	if not currState == WebSocketPeer.STATE_OPEN: return
	
	# Send intents
	if not sent_intents:
		client.send_text('["redeem"]')
		sent_intents = true
	
	if not client.get_available_packet_count(): return
	
	var strData = client.get_packet().get_string_from_utf8()
	JavaScriptBridge.get_interface('console').log('Data:', strData)
	var jsonObj = JSON.new()
	jsonObj.parse(strData)
	
	var data = jsonObj.data
	
	if typeof(data) != TYPE_DICTIONARY: return
	
	JavaScriptBridge.get_interface('console').log("reward", data["rewardTitle"])
	if data.has("rewardTitle") and reward_title.contains(data["rewardTitle"]):
		$AnimationPlayer.play_clap()
