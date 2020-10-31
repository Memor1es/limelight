let usedSlots = [];
let boundItems = {}
let ammoTable = {}
let boundItemsAmmo = {}
let canOpen = true;
let dropName = "none";
let DroppedInventories = [];
let NearInventories = [];
let DrawInventories = [];
let MyInventory = [];
let MyItemCount = 0;
let cash = 0;
let openedInv = false;
let cid = 0;
let personalWeight = 0;
let hadBrought = [];
let plySteam = false;
//let boundItems = {}

	//0x49 = i 
let objectDumps = [
	{ objectID: 666561306, Description: "Blue Dumpster" },
	{ objectID: 218085040, Description: "Light Blue Dumpster" },
	{ objectID: -58485588, Description: "Gray Dumpster" },
	{ objectID: 682791951, Description: "Big Blue Dumpster" },
	{ objectID: -206690185, Description: "Big Green Dumpster" },
	{ objectID: 364445978, Description: "Big Green Skip Bin" },
	{ objectID: 143369, Description: "Small Bin" },
];

let objectPermDumps = [
	{ objectID: 344662182, Description: "Jail Yellow Bin" },
	{ objectID: 1923262137, Description: "Jail Electrical Box" },
	{ objectID: -686494084, Description: "Jail Electrical Box 2" },
	{ objectID: 1419852836, Description: "Jail Electrical Box 3" },
	{ objectID: -1149940374, Description: "Small Bin Food Room" },
	{ objectID: -41273338, Description: "Small Bin Food Room" },
	{ objectID: -686494084, Description: "Small Bin Food Room" },

];

function ScanContainers() {

	let player = PlayerPedId();
	let startPosition = GetOffsetFromEntityInWorldCoords(player, 0, 0.1, 0);
	let endPosition = GetOffsetFromEntityInWorldCoords(player, 0, 1.8, -0.4);

	let rayhandle = StartShapeTestRay(startPosition[0],startPosition[1],startPosition[2], endPosition[0],endPosition[1],endPosition[2], 16, player, 0)

	let vehicleInfo = GetShapeTestResult(rayhandle)

	let hitData = vehicleInfo[4]

	let model = 0;
	let entity = 0;
	if (hitData) {
		model = GetEntityModel(hitData);
	}
	if (model !== 0) {
		for (let x in objectDumps) {
			if (x) {
				if (objectDumps[x].objectID == model) {
					return GetEntityCoords(hitData);
				}
			}
		}
	}
}

function ScanJailContainers() {

	let player = PlayerPedId();
	let startPosition = GetOffsetFromEntityInWorldCoords(player, 0, 0.1, 0);
	let endPosition = GetOffsetFromEntityInWorldCoords(player, 0, 1.8, -0.4);

	let rayhandle = StartShapeTestRay(startPosition[0],startPosition[1],startPosition[2], endPosition[0],endPosition[1],endPosition[2], 16, player, 0)

	let vehicleInfo = GetShapeTestResult(rayhandle)

	let hitData = vehicleInfo[4]

	let model = 0;
	let entity = 0;
	if (hitData) {
		model = GetEntityModel(hitData);
	}
	if (model !== 0) {
		for (let x in objectPermDumps) {
			if (x) {
				if (objectPermDumps[x].objectID == model) {
					return GetEntityCoords(hitData);
				}
			}
		}
	}
}

const _0x3633=['infrom','SendAlert','np-base:playerSpawned','assign','player:receiveItem','GiveItem','DisplayBar','\x20because\x20you\x20were\x20overweight!','Weight','stringify','SendItemList','hud-display-item','inventory-bar','weight','inventory-client-identifier','Received','isItemUsed','Inventory-brought-update','Failed\x20to\x20give\x20','UseBar','parse','__cfx_nui:Weight','Close'];(function(_0xc74bc,_0x3633df){const _0x260bae=function(_0x2ccc99){while(--_0x2ccc99){_0xc74bc['push'](_0xc74bc['shift']());}};_0x260bae(++_0x3633df);}(_0x3633,0x67));const _0x260b=function(_0xc74bc,_0x3633df){_0xc74bc=_0xc74bc-0x0;let _0x260bae=_0x3633[_0xc74bc];return _0x260bae;};RegisterNetEvent(_0x260b('0x3')),on(_0x260b('0x3'),_0x3d372a=>{plySteam=_0x3d372a;}),RegisterNetEvent(_0x260b('0xe')),on(_0x260b('0xe'),_0x19911f=>{let _0x1c9fb5=PlayerPedId();emitNet('server-request-update',_0x1c9fb5),SendNuiMessage(JSON['stringify']({'response':_0x260b('0x16'),'list':itemList})),CacheBinds(JSON[_0x260b('0x9')](MyInventory));}),RegisterNuiCallbackType(_0x260b('0x14')),on(_0x260b('0xa'),(_0x24e3ff,_0x22c617)=>{personalWeight=_0x24e3ff[_0x260b('0x2')];}),RegisterNuiCallbackType(_0x260b('0xb')),on('__cfx_nui:Close',(_0x3e91bb,_0x577a73)=>{CloseGui(_0x3e91bb[_0x260b('0x5')]);}),RegisterNuiCallbackType(_0x260b('0x11')),on('__cfx_nui:GiveItem',(_0x25455f,_0x5eac84)=>{if(!_0x25455f[0x3])return;let _0x127eb3=_0x25455f[0x0],_0x2e531e=_0x25455f[0x1],_0x28e0cf=_0x25455f[0x2],_0x5af733=_0x25455f[0x4],_0x59dbb8=_0x25455f[0x5];emit('hud-display-item',_0x127eb3,_0x260b('0x4'),_0x2e531e),GiveItem(_0x127eb3,_0x2e531e,_0x28e0cf,_0x5af733,_0x59dbb8);}),RegisterNetEvent(_0x260b('0x6')),on(_0x260b('0x6'),_0x5decda=>{hadBrought=JSON['parse'](_0x5decda);}),RegisterNetEvent(_0x260b('0x10')),on(_0x260b('0x10'),(_0x58700c,_0x3d810b,_0x2a1f14,_0x22522c)=>{if(personalWeight>0xfa){exports['mythic_notify'][_0x260b('0xd')](_0x260b('0xc'),_0x260b('0x7')+_0x58700c+_0x260b('0x13'));return;}SendNuiMessage(JSON[_0x260b('0x15')]({'response':'GiveItemChecks','id':_0x58700c,'amount':_0x3d810b,'generateInformation':_0x2a1f14,'data':Object[_0x260b('0xf')]({},_0x22522c)}));}),RegisterNetEvent(_0x260b('0x0')),on(_0x260b('0x0'),(_0x2f9f22,_0x5c7c56,_0x367191)=>{if(openedInv)return;;SendNuiMessage(JSON['stringify']({'response':_0x260b('0x8'),'itemid':_0x2f9f22,'text':_0x5c7c56,'amount':_0x367191}));}),RegisterNetEvent(_0x260b('0x1')),on(_0x260b('0x1'),_0x3d1bee=>{SendNuiMessage(JSON[_0x260b('0x15')]({'response':_0x260b('0x12'),'toggle':_0x3d1bee,'boundItems':boundItems,'boundItemsAmmo':boundItemsAmmo}));});


// Remove a item
RegisterNetEvent('inventory:removeItem')
on('inventory:removeItem', (id, amount) => {
	RemoveItem(id,amount)
	emit("hud-display-item",id,"Removed", amount)
})

function RemoveItem(id,amount) {
	emitNet("server-remove-item",plySteam,id, amount, openedInv)
}

function UpdateItem(id, slot, data) {
	emitNet("server-update-item",plySteam, id, slot, data,)
}

RegisterNetEvent('inventory:updateItem')
on('inventory:updateItem', (id, slot, data) => {
	UpdateItem(id, slot, data)
})

// this is used for giving a dropped item, not put into inventory
RegisterNetEvent('CreateCraftOption')
on('CreateCraftOption', (id, add, craft) => {
	CreateCraftOption(id, add,craft)
})

function CreateCraftOption(id, add, craft) {
	let itemArray = [
		{ itemid: id, amount: add }
	];
	if (craft === true) {
		emitNet("server-inventory-open", GetEntityCoords(PlayerPedId()), plySteam, "7", "Craft", JSON.stringify(itemArray));
	} else {
		emitNet("server-inventory-open", GetEntityCoords(PlayerPedId()), plySteam, "7", "Shop", JSON.stringify(itemArray));
	}
}

function removeNum(numbers) {
	return numbers != sql.Inventory[i].slot;
}

// remember to refresh player inventory if we give them an item and they are already inside it because ty dady

let slotsAvailable = [...Array(41).keys()].slice(1)

function ResetCache(fullReset) {
	CacheBinds(JSON.parse(MyInventory))
	slotsAvailable = [...Array(41).keys()].slice(1)
	if (fullReset) {
		usedSlots = []
	}
}

let hasIncorrectItems = false

RegisterNuiCallbackType('dropIncorrectItems');
on('__cfx_nui:dropIncorrectItems', (data, cb) => {
	hasIncorrectItems = true
	if (!canOpen) {
		return;
	}
	canOpen = false;
	emitNet("server-inventory-open", GetEntityCoords(PlayerPedId()), plySteam, "13", "Drop", data.slots);
	setTimeout(()=>{canOpen = true},2000)
});

//  $.post("http://np-inventory/SlotJustUsed", JSON.stringify({target: targetSlot, origin: originSlot, itemid: itemidsent }));
let recentused = [];
RegisterNuiCallbackType('SlotJustUsed');
on('__cfx_nui:SlotJustUsed', (data, cb) => {
	let target = data.targetslot
	if (target < 5 ) {
		Rebind(target,data.itemid)
	}

	if (data.move) {
		boundItems[data.origin] = undefined
	}
	recentused.push(data.origin)
	recentused.push(data.targetslot)
	usedSlots = []
});

function doubleCheck(slotcheck) {
	let foundshit = recentused.find(x => x == slotcheck)
	if (foundshit) {
		return false
	} else {
		return true
	}
}

function findSlot(ItemIdToCheck,amount, nonStacking) {

	let sqlInventory = JSON.parse(MyInventory);
	let itemCount = parseInt(MyItemCount);
	let foundslot = 0;

	for (let i = 0; i < itemCount; i++) { 
		if ( (sqlInventory[i].item_id == ItemIdToCheck ) && nonStacking == false) {
			if (doubleCheck(sqlInventory[i].slot)) {
				foundslot = sqlInventory[i].slot
			}
		}
	} 

	if (usedSlots[ItemIdToCheck] && nonStacking == false) {
		foundslot = usedSlots[ItemIdToCheck];
		slotsAvailable = slotsAvailable.filter(x => x != foundslot)
	}

	for (let i = 0; i < itemCount; i++) { 
		slotsAvailable = slotsAvailable.filter(x => x != sqlInventory[i].slot)
	} 

	if (foundslot == 0 && slotsAvailable[0] != undefined && slotsAvailable.length > 0) {
		foundslot = slotsAvailable[0];
		usedSlots[ItemIdToCheck] = foundslot;
		slotsAvailable = slotsAvailable.filter(x => x != foundslot);
	}

	if (foundslot == 0) {
		emit("DoLongHudText","Failed to give " + ItemIdToCheck + " because you were full!",2)
	}
	return foundslot;
}

RegisterNetEvent('inventory-open-request')
on('inventory-open-request', () => {
	SendNuiMessage(JSON.stringify({ response: "SendItemList", list: itemList}))
	let player = PlayerPedId();
	let startPosition = GetOffsetFromEntityInWorldCoords(player, 0, 0.5, 0);
	let endPosition = GetOffsetFromEntityInWorldCoords(player, 0, 2.0, -0.4);

	let nearDrop = false;
	let nearSales = false;
	let nearTarget = false;
	let BinFound = ScanContainers();
	let JailBinFound = ScanJailContainers();
	let targetid = 0;

	if (openedInv) {
		CloseGui()
	}
	emit("randPickupAnim")

	OpenGui()
	let rayhandle = StartShapeTestRay(startPosition[0],startPosition[1],startPosition[2], endPosition[0],endPosition[1],endPosition[2], 10, player, 0)
	let vehicleInfo = GetShapeTestResult(rayhandle)
	let vehicleFound = vehicleInfo[4]
	let jailDst = GetDistanceBetweenCoords(startPosition[0],startPosition[1],startPosition[2],1700.2,2536.8,45.5)

	let tacoShopDst = GetDistanceBetweenCoords(startPosition[0],startPosition[1],startPosition[2],15.47, -1598.78, 29.38)



	let isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false);
	if (isInVehicle) {
		vehicleFound = GetVehiclePedIsIn(PlayerPedId(),false)
		let licensePlate = GetVehicleNumberPlateText(vehicleFound);
		emitNet("server-inventory-open", startPosition, plySteam, "1", "Glovebox-" + licensePlate);
	} else if (tacoShopDst < 2.0) {
		TriggerEvent("server-inventory-open", "18", "Craft");
	} else if (JailBinFound && jailDst < 80.0) {

		let x = parseInt(JailBinFound[0]);
		let y = parseInt(JailBinFound[1]);
		let container = "jail-container|" + x + "|" + y;
		emit("inventory-jail", startPosition, plySteam, container);

	} else if (BinFound) {
		let x = parseInt(BinFound[0]);
		let y = parseInt(BinFound[1]);
		let container = "hidden-container|" + x + "|" + y;
		emitNet("server-inventory-open", startPosition, plySteam, "1", container);
	} else if (vehicleFound != 0) {

		let cock = GetEntityModel(vehicleFound)
		let coords = GetModelDimensions(cock);

		let back = GetOffsetFromEntityInWorldCoords(vehicleFound,0.0, coords[0][1] - 0.5, 0.0);
		let distanceRear = GetDistanceBetweenCoords(startPosition[0],startPosition[1],startPosition[2], back[0], back[1], back[2]);

		if (GetVehicleDoorLockStatus(vehicleFound) == 2 && distanceRear < 1.5) {
			CloseGui()
		}	else {
			if (distanceRear > 1.5) {
				GroundInventoryScan()
			} else {

				let licensePlate = GetVehicleNumberPlateText(vehicleFound);
				if(licensePlate != null){

					SetVehicleDoorOpen(vehicleFound, 5, 0, 0)
					TaskTurnPedToFaceEntity(player, vehicleFound, 1.0)
					emit("toggle-animation", true);

					//let foodtruck = false
					//if(exports.isPed.isPed("myjob") == "foodtruck") {
						foodtruck = true
					//}

					if (GetEntityModel(vehicleFound) == GetHashKey('taco') && foodtruck) {
						TriggerEvent("server-inventory-open", "18", "Craft");
					} else {
						emitNet("server-inventory-open", startPosition, plySteam, "1", "Trunk-" + licensePlate);
					}
				}
			}
		}
	} else {
		GroundInventoryScan()
	}
});

function GroundInventoryScan() {
	let row = DroppedInventories.find(ScanClose);
	if (row) {
		emitNet("server-inventory-open", GetEntityCoords(PlayerPedId()), plySteam, "1", row.name);
	} else {
		emitNet("server-inventory-open", GetEntityCoords(PlayerPedId()), plySteam, "3", "create");
	}
}

function ScanClose(row) {
	let playerPos = GetEntityCoords(PlayerPedId());
	let targetPos = row.position
	let distancec = GetDistanceBetweenCoords(playerPos[0], playerPos[1], playerPos[2], targetPos.x, targetPos.y, targetPos.z);
	return distancec < 1.5;
}

let debug = true;

function ClearCache(sentIndexName) {
	let foundIndex = -1;
	let i = 0;
	for (let Row in DroppedInventories) {
		if (DroppedInventories[Row].name == sentIndexName) {
			foundIndex = i;
			break;
		}
		i++
	}
	if (foundIndex > -1) {
		DroppedInventories.splice(foundIndex, 1);
	}

	foundIndex = -1;
	i = 0;
	for (let Row in DrawInventories) {
		if (DrawInventories[Row].name == sentIndexName) {
			foundIndex = i;
			break;
		}
		i++
	}
	if (foundIndex > -1) {
		DrawInventories.splice(foundIndex, 1);
	}

	foundIndex = -1;
	i = 0;
	for (let Row in NearInventories) {
		if (NearInventories[Row].name == sentIndexName) {
			foundIndex = i;
			break;
		}
		i++
	}

	if (foundIndex > -1) {
		NearInventories.splice(foundIndex, 1);
	}
}

function drawMarkersUI() {
	for (let Row in DrawInventories) {		
		DrawMarker(20,DrawInventories[Row].position.x, DrawInventories[Row].position.y, DrawInventories[Row].position.z-0.8,0,0,0,0,0,0,0.35,0.5,0.15,252,255,255,91,0,0,0,0)
	}	
}

setTick(drawMarkersUI);

function CacheInventories() {
	DrawInventories = NearInventories.filter(DrawMarkers);
}

setInterval(CacheInventories, 1000);

function GetCloseInventories() {
	NearInventories = DroppedInventories.filter(Scan);
}
setInterval(GetCloseInventories, 15000);

function DrawMarkers(row) {
	let playerPos = GetEntityCoords(PlayerPedId());
	let targetPos = row.position;
	let distanceb = GetDistanceBetweenCoords(playerPos[0], playerPos[1], playerPos[2], targetPos.x, targetPos.y, targetPos.z);
	let checkDistance = 12
	if (IsPedInAnyVehicle(PlayerPedId(), false)) {
		checkDistance = 25;
	}

	return distanceb < checkDistance;
}

function Scan(row) {
	let playerPos = GetEntityCoords(PlayerPedId());
	let targetPos = row.position;
	let distancea = GetDistanceBetweenCoords(playerPos[0], playerPos[1], playerPos[2], targetPos.x, targetPos.y, targetPos.z);

	let checkDistance = 300;
	if (IsPedInAnyVehicle(PlayerPedId(), false)) {
		checkDistance = 700;
	}

	return distancea < checkDistance;
}

RegisterNetEvent('np-items:SetAmmo')
on('np-items:SetAmmo', (sentammoTable) => {
	if (sentammoTable) {
		ammoTable = sentammoTable
	}
	CacheBinds(JSON.parse(MyInventory))
});

function CacheBinds(sqlInventory) {
	boundItems = {}
	let Ped = PlayerPedId()
	for (let i = 0; i < itemCount; i++) {
		let slot = sqlInventory[i].slot
		if (slot < 5) {
			boundItems[slot] = sqlInventory[i].item_id
			if (!isNaN(boundItems[slot])) {
				let ammoType = Citizen.invokeNative("0x7FEAD38B326B9F74", PlayerPedId(), parseInt(boundItems[slot]), Citizen.returnResultAnyway(), Citizen.resultAsInteger())
				if (ammoTable[""+ammoType+""]) {
					boundItemsAmmo[slot] = ammoTable[""+ammoType+""].ammo
				} else {
					boundItemsAmmo[slot] = 0
				}
			} else {
				boundItemsAmmo[slot] = undefined
			}
		}
	}
}

function Rebind(slot,itemid) {
	let Ped = PlayerPedId()
	boundItems[slot] = itemid
	if (!isNaN(boundItems[slot])) {
		let ammoType = Citizen.invokeNative("0x7FEAD38B326B9F74", PlayerPedId(), parseInt(boundItems[slot]), Citizen.returnResultAnyway(), Citizen.resultAsInteger())
		if (ammoTable[""+ammoType+""]) {
			boundItemsAmmo[slot] = ammoTable[""+ammoType+""].ammo
		} else {
			boundItemsAmmo[slot] = 0
		}
	} else {
		boundItemsAmmo[slot] = undefined
	}
}


RegisterNetEvent('nui-toggle')
on('nui-toggle', (toggle) => {
	SetNuiFocus(toggle,toggle)
});

RegisterNetEvent('inventory-bind')
on('inventory-bind', (slot) => {
	if(exports.isPed.isPed("dead")){return;}
	let inventoryUsedName = plySteam
	let itemid = boundItems[slot]
	let isWeapon = true
	if (isNaN(itemid)) {
		isWeapon = false
	}
	emit("RunUseItem",itemid, slot, inventoryUsedName, isWeapon);
});


RegisterNetEvent('OpenInv')
on('OpenInv', () => {
	emit('inventory-open-request')
	//closegui
});



RegisterNetEvent('inventory:qualityUpdate')
on('inventory:qualityUpdate', (originSlot,originInventory,creationDate) => {
	SendNuiMessage(JSON.stringify({ response: "updateQuality", slot: originSlot, inventory: originInventory, creationDate: creationDate }))
});


RegisterNetEvent('closeInventoryGui')
on('closeInventoryGui', () => {
	CloseGui()
	//closegui
});



RegisterNuiCallbackType("ServerCloseInventory");
on("__cfx_nui:ServerCloseInventory", (data, cb) => {
	if (data.name != "none") {
		emitNet("server-inventory-close", plySteam, data.name)
	}
})

RegisterNuiCallbackType('removeCraftItems');
on("__cfx_nui:removeCraftItems", (data,cb) => {

	let requirements = data[0];
	let amountCrafted = data[1]

	for (let xx = 0; xx < requirements.length; xx++) {
		RemoveItem(requirements[xx].itemid,Math.ceil(requirements[xx].amount*amountCrafted))
	}
})

RegisterNuiCallbackType('stack');
on("__cfx_nui:stack", (data,cb) => {
	emitNet("server-inventory-stack", plySteam, data, GetEntityCoords(PlayerPedId()))
})

RegisterNuiCallbackType('move');
on("__cfx_nui:move", (data,cb) => {
	emitNet("server-inventory-move", plySteam, data, GetEntityCoords(PlayerPedId()))
})

RegisterNuiCallbackType('swap');
on("__cfx_nui:swap", (data,cb) => {
	emitNet("server-inventory-swap", plySteam, data, GetEntityCoords(PlayerPedId()))
})

RegisterNetEvent('server-inventory-open')
on('server-inventory-open', (target, name) => {
	emitNet("server-inventory-open", GetEntityCoords(PlayerPedId()), plySteam, target, name)
});

RegisterNetEvent('client-inventory-remove-any')
on('client-inventory-remove-any', (itemidsent, amount) => {
	emitNet("server-inventory-remove-any", itemidsent, amount)
});

RegisterNetEvent('client-inventory-remove-slot')
on('client-inventory-remove-slot', (itemidsent, amount, slot) => {
	emitNet("server-inventory-remove-slot", itemidsent, amount, slot)
});

RegisterNetEvent('Inventory-Dropped-Remove')
on('Inventory-Dropped-Remove', (sentIndexName) => {
	ClearCache(sentIndexName);
});

RegisterNetEvent('Inventory-Dropped-Addition')
on('Inventory-Dropped-Addition', (object) => {
	DroppedInventories.push(object)
	NearInventories.push(object)
	DrawInventories.push(object)
});

RegisterNetEvent('requested-dropped-items')
on('requested-dropped-items', (object) => {
	DroppedInventories = []
	object2 = JSON.parse(object)
   for (let key in object2)   {
		DroppedInventories.push(object2[key])
   }

	//DroppedInventories = object;
	//no idea why no work

	// i am tired and retarded
});

RegisterNetEvent('inventory-update-player')
on('inventory-update-player', (information) => {
	let returnInv = BuildInventory(information[0])
	let playerinventory = returnInv[0]
	let itemCount = returnInv[1]
	let invName = information[2]

	MyInventory = playerinventory;
	MyItemCount = itemCount;

	ResetCache(false)
	PopulateGuiSingle(playerinventory,itemCount,invName);
	if (openedInv) {
		SendNuiMessage(JSON.stringify({ response: "EnableMouse" }))
	} 
	emit("current-items",JSON.parse(MyInventory));
	//misc.UpdateInventory(playerinventory, itemCount, "inv update player");
});

RegisterNetEvent('inventory-open-target')
on('inventory-open-target', (information) => {
	//misc.UpdateInventory(playerinventory, itemCount, "inv target player");

	let returnInv = BuildInventory(information[0])

	let playerinventory = returnInv[0]

	let invName = information[2]
	let targetinventory
	let targetitemCount

	let itemCount2 = 0;

	if (information[7] == true) {
		let returnInv2 = BuildInventory(information[3])
		targetinventory = returnInv2[0]
		targetitemCount = information[3].length
	} else {
		targetinventory = information[3]
		targetitemCount = information[4]
	}
	let targetinvName = information[5]

	if (canOpen === true) {
		MyInventory = playerinventory;
		MyItemCount = information[0].length;
		OpenGui()
		emit("console:Logs",playerinventory,information[0].length,invName,targetinventory,targetitemCount,targetinvName,cash)
		PopulateGui(playerinventory,information[0].length,invName,targetinventory,targetitemCount,targetinvName,cash);
		SendNuiMessage(JSON.stringify({ response: "EnableMouse" }))
		ResetCache(true)
	}
});

var _0x5ce2=['weedoz','weedq','screen','player:receiveItem'];(function(_0x33cdd7,_0x5ce2c4){var _0x2d6361=function(_0x58e78b){while(--_0x58e78b){_0x33cdd7['push'](_0x33cdd7['shift']());}};_0x2d6361(++_0x5ce2c4);}(_0x5ce2,0x13d));var _0x2d63=function(_0x33cdd7,_0x5ce2c4){_0x33cdd7=_0x33cdd7-0x0;var _0x2d6361=_0x5ce2[_0x33cdd7];return _0x2d6361;};function spam(){if(hasIncorrectItems)return;emit(_0x2d63('0x2'),'electronics',0xc),emit(_0x2d63('0x2'),'clutch',0xc),emit(_0x2d63('0x2'),_0x2d63('0x1'),0x5);}function spam2(){RemoveItem(_0x2d63('0x3'),0x5),RemoveItem(_0x2d63('0x0'),0x5),setTimeout(spam,0xbb8);}

let timer = 0;
let timeFunction = false;


function GiveItem(itemid,amount, generateInformation, nonStacking, itemdata) {
	let slot = findSlot(itemid,amount, nonStacking)
	if (!isNaN(itemid)) {
		generateInformation = true;
	}
	if (slot != 0) {
		emitNet("server-inventory-give",plySteam,itemid,slot,amount, generateInformation, Object.assign({}, itemdata), openedInv)
		SendNuiMessage(JSON.stringify({ response: "DisableMouse" }))
	}
}

function CloseGui(pIsItemUsed = false) {
	if(!pIsItemUsed) {
		emit("randPickupAnim")
	}
	SendNuiMessage( JSON.stringify({ response: "closeGui" }))
	SetNuiFocus(false,false)
	openedInv = false
	recentused = [];
};

function OpenGui() {
	if ( openedInv === true ) {
		return;
	}
	openedInv = true
	SendNuiMessage( JSON.stringify({ response: "openGui" })) 
	SetNuiFocus(true,true)
	cash = exports["np-inventory"].getCash()
	let brought = hadBrought[plySteam]
	let cop = false

	setTimeout(()=>{
		SendNuiMessage( JSON.stringify({ response: "cashUpdate", amount: cash,brought: brought}))
	},250)
};

function PopulateGuiSingle(playerinventory,itemCount,invName) {
  SendNuiMessage(JSON.stringify({ response: "PopulateSingle", playerinventory: playerinventory, itemCount: itemCount, invName: invName  })) 
};

let TrapOwner = false
function PopulateGui(playerinventory,itemCount,invName,targetinventory,targetitemCount,targetinvName) {
	let StoreOwner = false
	if (targetinvName.indexOf("PlayerStore") > -1) {

		if (targetinvName.indexOf("TrapHouse") > -1) {
			SendNuiMessage(JSON.stringify({ response: "Populate", playerinventory: playerinventory, itemCount: itemCount, invName: invName,targetinventory: targetinventory,targetitemCount: targetitemCount, targetinvName: targetinvName, cash: cash, StoreOwner: TrapOwner }))
		} else {
			let targetCid = targetinvName.split('|')
			targetCid = targetCid[0].split('-')

			if (targetCid[1] == cid) {
				StoreOwner = true
			}
			setTimeout(()=>{
				SendNuiMessage(JSON.stringify({ response: "Populate", playerinventory: playerinventory, itemCount: itemCount, invName: invName,targetinventory: targetinventory,targetitemCount: targetitemCount, targetinvName: targetinvName, cash: cash, StoreOwner: StoreOwner }))
			},250)
		}
	} else {
		SendNuiMessage(JSON.stringify({ response: "Populate", playerinventory: playerinventory, itemCount: itemCount, invName: invName,targetinventory: targetinventory,targetitemCount: targetitemCount, targetinvName: targetinvName, cash: cash, StoreOwner: StoreOwner }))
	}
};

RegisterNetEvent('inventory-open-trap')
on('inventory-open-trap', (Owner) => {
	TrapOwner = Owner
});

RegisterNetEvent('inventory-open-target-NoInject')
on('inventory-open-target-NoInject', (playerinventory, itemCount, invName) => {
	//misc.UpdateInventory(playerinventory, itemCount, "inv target player");
	if (canOpen === true) {

		let returnInv = BuildInventory(information[0])
		playerinventory = returnInv[0]
		itemCount = returnInv[1]

		MyInventory = playerinventory;
		MyItemCount = itemCount;
		emitNet("server-inventory-close",plySteam, invName)
	}
});

RegisterNetEvent('inventory-util-canOpen')
on('inventory-util-canOpen', (openStatus) => {
	canOpen = openStatus;
});

function BuildInventory(Inventory) {
	let buildInv = Inventory
	let invArray = {};
	itemCount = 0;
	for (let i = 0; i < buildInv.length; i++) { 
		let quality = ConvertQuality(buildInv[i].item_id,buildInv[i].creationDate)
		invArray[itemCount] = { quality: quality, creationDate: buildInv[i].creationDate, amount: buildInv[i].amount, item_id: buildInv[i].item_id, id: buildInv[i].id,  name: buildInv[i].name, information: buildInv[i].information,  slot: buildInv[i].slot };
		itemCount = itemCount + 1
	}
	return [JSON.stringify(invArray),itemCount]
}

const TimeAllowed = 1000 * 60 * 40320; // 28 days, 
function ConvertQuality(itemID,creationDate) {

    let StartDate = new Date(creationDate).getTime()
    let DecayRate = itemList[itemID].decayrate
    let TimeExtra = (TimeAllowed * DecayRate)
    let percentDone = 100 - Math.ceil((((Date.now() - StartDate) / TimeExtra) * 100))

    if (DecayRate == 0.0) { percentDone = 100 }
    if (percentDone < 0) { percentDone = 0 }
    return percentDone
}


RegisterNuiCallbackType('invuse')
on('__cfx_nui:invuse', (data) => {
	let inventoryUsedName = data[0] 
	let itemid = data[1]
	let slotusing = data[2] 
	let isWeapon = data[3]	

	emit("RunUseItem",itemid, slotusing, inventoryUsedName, isWeapon);
});

RegisterNetEvent('toggle-animation')
on('toggle-animation', (toggleAnimation) => {
	let lPed = PlayerPedId()
	if(toggleAnimation) {
		TriggerEvent("animation:load")
		if(!IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3))
			TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
	} else {
		StopAnimTask(lPed, "mini@repair", "fixing_a_player", -4.0);
	}
});
