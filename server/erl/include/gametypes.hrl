-export([kinds/0, 
        get_type/1,
        get_kind_as_string/1, 
        get_kind_from_string/1,
        get_message_type_as_string/1,
        is_mob/1,
        is_npc/1,
        is_armor/1,
        is_weapon/1,
        is_object/1,
        is_chest/1,
        is_item/1,
        get_weapon_rank/1,
        get_armor_rank/1,
        is_healing_item/1
    ]).

%% spawn_entity => SPAWN
%% kill_entity => KILL
%% list_entites => LIST
-record(messages, {
            hello = {0, "hello"},
            welcome = {1, "welcome"},
            spawn_entity = {2, "spawn"},
            despawn = {3, "despawn"},
            move = {4, "move"},
            lootmove = {5, "lootmove"},
            aggro = {6, "aggro"},
            attack = {7, "attack"},
            hit = {8, "hit"},
            hurt = {9, "hurt"},
            health = {10, "health"},
            chat = {11, "chat"},
            loot = {12, "loot"},
            equip = {13, "equip"},
            drop = {14, "drop"},
            teleport = {15, "teleport"},
            damage = {16, "damage"},
            population = {17, "population"},
            kill_entity = {18, "kill"},
            list_entities = {19, "list"},
            who = {20, "who"},
            zone = {21, "zone"},
            destroy = {22, "destroy"},
            hp = {23, "hp"},
            blink = {24, "blink"},
            open = {25, "open"},
            check = {26, "check"}}).

-record(entities, {
            warrior = 1,
            rat = 2,
            skeleton = 3,
            goblin = 4,
            ogre = 5,
            spectre = 6,
            crab = 7,
            bat = 8,
            wizard = 9,
            eye = 10,
            snake = 11,
            skeleton2 = 12,
            boss = 13,
            deathknight = 14,
            firefox = 20,
            clotharmor = 21,
            leatherarmor = 22,
            mailarmor = 23,
            platearmor = 24,
            redarmor = 25,
            goldenarmor = 26,
            flask = 35,
            burger = 36,
            chest = 37,
            firepotion = 38,
            cake = 39,
            guard = 40,
            king = 41,
            octocat = 42,
            villagegirl = 43,
            villager = 44,
            priest = 45,
            scientist = 46,
            agent = 47,
            rick = 48,
            nyan = 49,
            sorcerer = 50,
            beachnpc = 51,
            forestnpc = 52,
            desertnpc = 53,
            lavanpc = 54,
            coder = 55,
            sword1 = 60,
            sword2 = 61,
            redsword = 62,
            goldensword = 63,
            morningstar = 64,
            axe = 65,
            bluesword = 66}).

-record(orientations, {
        up = 1,
        down = 2,
        left = 3,
        right = 4}).

kinds() ->
    E = #entities{},
    [
        {warrior, [E#entities.warrior, "player"]},

        {rat, [E#entities.rat, "mob"]},
        {skeleton, [E#entities.skeleton, "mob"]},
        {goblin, [E#entities.goblin, "mob"]},
        {ogre, [E#entities.ogre, "mob"]},
        {spectre, [E#entities.spectre, "mob"]},
        {deathknight, [E#entities.deathknight, "mob"]},
        {crab, [E#entities.crab, "mob"]},
        {snake, [E#entities.snake, "mob"]},
        {bat, [E#entities.bat, "mob"]},
        {wizard, [E#entities.wizard, "mob"]},
        {eye, [E#entities.eye, "mob"]},
        {skeleton2, [E#entities.skeleton2, "mob"]},
        {boss, [E#entities.boss, "mob"]},

        {sword1, [E#entities.sword1, "weapon"]},
        {sword2, [E#entities.sword2, "weapon"]},
        {axe, [E#entities.axe, "weapon"]},
        {morningstar, [E#entities.morningstar, "weapon"]},
        {bluesword, [E#entities.bluesword, "weapon"]},
        {redsword, [E#entities.redsword, "weapon"]},
        {goldensword, [E#entities.goldensword, "weapon"]},

        {firefox, [E#entities.firefox, "armor"]},
        {clotharmor, [E#entities.clotharmor, "armor"]},
        {leatherarmor, [E#entities.leatherarmor, "armor"]},
        {mailarmor, [E#entities.mailarmor, "armor"]},
        {platearmor, [E#entities.platearmor, "armor"]},
        {redarmor, [E#entities.redarmor, "armor"]},
        {goldenarmor, [E#entities.goldenarmor, "armor"]},

        {flask, [E#entities.flask, "object"]},
        {cake, [E#entities.cake, "object"]},
        {burger, [E#entities.burger, "object"]},
        {chest, [E#entities.chest, "object"]},
        {firepotion, [E#entities.firepotion, "object"]},

        {guard, [E#entities.guard, "npc"]},
        {villagegirl, [E#entities.villagegirl, "npc"]},
        {villager, [E#entities.villager, "npc"]},
        {coder, [E#entities.coder, "npc"]},
        {scientist, [E#entities.scientist, "npc"]},
        {priest, [E#entities.priest, "npc"]},
        {king, [E#entities.king, "npc"]},
        {rick, [E#entities.rick, "npc"]},
        {nyan, [E#entities.nyan, "npc"]},
        {sorcerer, [E#entities.sorcerer, "npc"]},
        {agent, [E#entities.agent, "npc"]},
        {octocat, [E#entities.octocat, "npc"]},
        {beachnpc, [E#entities.beachnpc, "npc"]},
        {forestnpc, [E#entities.forestnpc, "npc"]},
        {desertnpc, [E#entities.desertnpc, "npc"]},
        {lavanpc, [E#entities.lavanpc, "npc"]}
    ].

get_kind_as_string(Kind) ->
    get_kind_as_string(Kind, kinds()).
get_kind_as_string(Kind, [{String, [Kind | Value]} | _Rest]) ->
    {String, [Kind | Value]};
get_kind_as_string(Kind, [_Head | Rest]) ->
    get_kind_as_string(Kind, Rest).

get_kind_from_string(String) ->
    get_kind_from_string(String, kinds()).
get_kind_from_string(String, [{String, [Kind | Value]} | _Rest]) ->
    {String, [Kind | Value]};
get_kind_from_string(String, [_Head | Rest ]) ->
    get_kind_from_string(String, Rest).

get_message_type_as_string(Type) ->
    {_Value, String} = Type,
    String.

get_type(Kind) ->
    {_Kind, [_Value | String]} = get_kind_as_string(Kind),
    [Value] = String,
    Value.

is_mob(Kind) ->
    get_type(Kind) =:= "mob".

is_npc(Kind) ->
    get_type(Kind) =:= "npc".

is_armor(Kind) ->
    get_type(Kind) =:= "armor".

is_weapon(Kind) ->
    get_type(Kind) =:= "weapon".

is_object(Kind) ->
    get_type(Kind) =:= "object".

is_chest(Kind) ->
    E = #entities{},
    Kind =:= E#entities.chest.

is_item(Kind) ->
    is_weapon(Kind) or is_armor(Kind) or is_object(Kind) and not(is_chest(Kind)).

get_weapon_rank(Kind) ->
    Weapons = [Weapon || {_, [Weapon, "weapon"]} <- kinds()],
    get_rank(Weapons, Kind, 0).

get_armor_rank(Kind) ->
    Armors = [Armor || {_, [Armor, "armor"]} <- kinds()],
    get_rank(Armors, Kind, -1).

get_rank([Kind | _Rest], Kind, Value) ->
    Value;
get_rank([_ | Rest], Kind, Value) ->
    get_rank(Rest, Kind, Value + 1);
get_rank([], _, _) -> -1.

is_healing_item(Kind) ->
    E = #entities{},
    Flask = Kind =:= E#entities.flask,
    Burger = Kind =:= E#entities.burger,
    Flask or Burger.
