chance_none = 50;
chance_common = 30;
chance_uncommon = 15;
chance_rare = 5;

item_generated = noone;

var roll = irandom(100);

if (roll < chance_none) {
    item_generated = noone;
} else if (roll < chance_none + chance_common) {
    item_generated = instance_create_layer(x, y, "Items", obj_ItemSlowVision);
} else if (roll < chance_none + chance_common + chance_uncommon) {
    item_generated = instance_create_layer(x, y, "Items", obj_ItemStopVision);
} else {
    // Truc bizarre pas sensé arriver
}
