-export([kinds/0, 
        get_type/1,
        get_kind_as_string/1, 
        get_kind_from_string/1,
        get_message_type_as_string/1,
        is_mob/1
    ]).
%% TODO: isNpc, isItem, isArmor, isWeapon, isHealingItem, getArmorRank, getWeaponRank

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
    [
        {warrior, [#entities.warrior, "player"]},
        {rat, [#entities.rat, "mob"]},
        {skeleton, [#entities.skeleton, "mob"]}
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
