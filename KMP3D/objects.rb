module KMP3D
  module Objects
    module_function

    def name_from_id(id)
      LIST.each do |name, obj|
        return name if obj.id == id.to_i
      end
      puts "Unrecognized object #{id}"
      return "point" # by default
    end

    Object = Struct.new(:id, :model)
    LIST = {
      "airblock" => Object.new(1, "point"),
      "Psea" => Object.new(2, "Psea"),
      "lensFX" => Object.new(3, "point"),
      "venice_nami" => Object.new(4, "venice_nami"),
      "sound_river" => Object.new(5, "point"),
      "sound_water_fall" => Object.new(6, "point"),
      "pocha" => Object.new(7, "pocha"),
      "sound_lake" => Object.new(8, "point"),
      "sound_big_fall" => Object.new(9, "point"),
      "sound_sea" => Object.new(10, "point"),
      "sound_fountain" => Object.new(11, "point"),
      "sound_volcano" => Object.new(12, "point"),
      "sound_audience" => Object.new(13, "point"),
      "sound_big_river" => Object.new(14, "point"),
      "sound_sand_fall" => Object.new(15, "point"),
      "sound_lift" => Object.new(16, "point"),
      "pochaYogan" => Object.new(17, "pochaYogan"),
      "entry" => Object.new(18, "point"),
      "pochaMori" => Object.new(19, "point"),
      "eline_control" => Object.new(20, "point"),
      "sound_Mii" => Object.new(21, "point"),
      "begoman_manager" => Object.new(22, "point"),
      "ice" => Object.new(23, "ice"),
      "startline2D" => Object.new(24, "point"),
      "itembox" => Object.new(101, "itembox"),
      "DummyPole" => Object.new(102, "point"),
      "flag" => Object.new(103, "point"),
      "flagBlend" => Object.new(104, "point"),
      "gnd_sphere" => Object.new(105, "point"),
      "gnd_trapezoid" => Object.new(106, "point"),
      "gnd_wave1" => Object.new(107, "point"),
      "gnd_wave2" => Object.new(108, "point"),
      "gnd_wave3" => Object.new(109, "point"),
      "gnd_wave4" => Object.new(110, "point"),
      "sun" => Object.new(111, "sun"),
      "woodbox" => Object.new(112, "woodbox"),
      "KmoonZ" => Object.new(113, "KmoonZ"),
      "sunDS" => Object.new(114, "sunDS"),
      "coin" => Object.new(115, "coin"),
      "ironbox" => Object.new(116, "point"),
      "ItemDirect" => Object.new(117, "point"),
      "s_itembox" => Object.new(118, "itembox"),
      "pile_coin" => Object.new(119, "coin"),
      "f_itembox" => Object.new(201, "itembox"),
      "MashBalloonGC" => Object.new(202, "MashBalloonGC"),
      "WLwallGC" => Object.new(203, "WLwallGC"),
      "CarA1" => Object.new(204, "CarA1"),
      "basabasa" => Object.new(205, "basabasa"),
      "HeyhoShipGBA" => Object.new(206, "HeyhoShipGBA"),
      "koopaBall" => Object.new(207, "koopaBall"),
      "kart_truck" => Object.new(208, "K_truck"),
      "car_body" => Object.new(209, "K_car_body"),
      "skyship" => Object.new(210, "skyship"),
      "w_woodbox" => Object.new(211, "woodbox"),
      "w_itembox" => Object.new(212, "itembox"),
      "w_itemboxline" => Object.new(213, "point"),
      "VolcanoBall1" => Object.new(214, "VolcanoBall1"),
      "penguin_s" => Object.new(215, "penguin_s"),
      "penguin_m" => Object.new(216, "penguin_m"),
      "penguin_l" => Object.new(217, "penguin_l"),
      "castleballoon1" => Object.new(218, "castleballoon1"),
      "dossunc" => Object.new(219, "dossun"),
      "dossunc_soko" => Object.new(220, "point"),
      "boble" => Object.new(221, "boble"),
      "K_bomb_car" => Object.new(222, "K_bomb_car"),
      "K_bomb_car_dummy" => Object.new(223, "point"),
      "car_body_dummy" => Object.new(224, "point"),
      "kart_truck_dummy" => Object.new(225, "point"),
      "hanachan" => Object.new(226, "hanachan"),
      "seagull" => Object.new(227, "seagull"),
      "moray" => Object.new(228, "moray"),
      "crab" => Object.new(229, "crab"),
      "basabasa_dummy" => Object.new(230, "point"),
      "CarA2" => Object.new(231, "CarA2"),
      "CarA3" => Object.new(232, "CarA3"),
      "Hwanwan" => Object.new(233, "wanwan"),
      "HeyhoBallGBA" => Object.new(234, "HeyhoBallGBA"),
      "Twanwan" => Object.new(235, "Twanwan"),
      "cruiserR" => Object.new(236, "cruiser"),
      "bird" => Object.new(237, "bird"),
      "sin_itembox" => Object.new(238, "itembox"),
      "Twanwan_ue" => Object.new(239, "point"),
      "BossHanachan" => Object.new(240, "hanachan"),
      "Kdossunc" => Object.new(241, "point"),
      "BossHanachanHead" => Object.new(242, "point"),
      "K_bomb_car1" => Object.new(243, "point"),
      "dummy" => Object.new(301, "point"),
      "dokan_sfc" => Object.new(302, "dokan_sfc"),
      "castletree1" => Object.new(303, "castletree1"),
      "castletree1c" => Object.new(304, "castletree1"),
      "castletree2" => Object.new(305, "castletree2"),
      "castleflower1" => Object.new(306, "castleflower1"),
      "mariotreeGC" => Object.new(307, "mariotreeGC"),
      "mariotreeGCc" => Object.new(308, "mariotreeGC"),
      "donkytree1GC" => Object.new(309, "donkytree1GC"),
      "donkytree2GC" => Object.new(310, "donkytree2GC"),
      "peachtreeGC" => Object.new(311, "peachtreeGC"),
      "peachtreeGCc" => Object.new(312, "peachtreeGC"),
      "npc_mii_a" => Object.new(313, "point"),
      "npc_mii_b" => Object.new(314, "point"),
      "npc_mii_c" => Object.new(315, "point"),
      "obakeblockSFCc" => Object.new(316, "obakeblockSFC"),
      "WLarrowGC" => Object.new(317, "WLarrowGC"),
      "WLscreenGC" => Object.new(318, "WLscreenGC"),
      "WLdokanGC" => Object.new(319, "WLdokanGC"),
      "MarioGo64c" => Object.new(320, "MarioGo64"),
      "PeachHunsuiGC" => Object.new(321, "PeachHunsuiGC"),
      "kinokoT1" => Object.new(322, "kinokoT1"),
      "kinokoT2" => Object.new(323, "point"),
      "pylon01" => Object.new(324, "pylon01"),
      "PalmTree" => Object.new(325, "PalmTree"),
      "parasol" => Object.new(326, "parasol"),
      "cruiser" => Object.new(327, "cruiser"),
      "K_sticklift00" => Object.new(328, "K_sticklift00"),
      "heyho2" => Object.new(329, "point"),
      "HeyhoTreeGBAc" => Object.new(330, "HeyhoTreeGBA"),
      "MFaceBill" => Object.new(331, "point"),
      "truckChimSmk" => Object.new(332, "truckChimSmk"),
      "MiiObj01" => Object.new(333, "MiiObj01"),
      "MiiObj02" => Object.new(334, "MiiObj02"),
      "MiiObj03" => Object.new(335, "MiiObj03"),
      "gardentreeDS" => Object.new(336, "gardentreeDS"),
      "gardentreeDSc" => Object.new(337, "gardentreeDS"),
      "FlagA1" => Object.new(338, "FlagA1"),
      "FlagA2" => Object.new(339, "FlagA2"),
      "FlagB1" => Object.new(340, "FlagB1"),
      "FlagB2" => Object.new(341, "FlagB2"),
      "FlagA3" => Object.new(342, "FlagA3"),
      "DKtreeA64" => Object.new(343, "DKtreeA64"),
      "DKtreeA64c" => Object.new(344, "DKtreeA64"),
      "DKtreeB64" => Object.new(345, "DKtreeB64"),
      "DKtreeB64c" => Object.new(346, "DKtreeB64"),
      "TownTreeDSc" => Object.new(347, "TownTreeDS"),
      "Piston" => Object.new(348, "Piston"),
      "oilSFC" => Object.new(349, "oilSFC"),
      "DKmarutaGCc" => Object.new(350, "point"),
      "DKropeGCc" => Object.new(351, "point"),
      "mii_balloon" => Object.new(352, "mii_balloon"),
      "windmill" => Object.new(353, "windmill"),
      "dossun" => Object.new(354, "dossun"),
      "TownTreeDS" => Object.new(355, "TownTreeDS"),
      "Ksticketc" => Object.new(356, "Ksticketc"),
      "monte_a" => Object.new(357, "monte_a"),
      "MiiStatueM1" => Object.new(358, "MiiStatueM1"),
      "ShMiiObj01" => Object.new(359, "ShMiiObj01"),
      "ShMiiObj02" => Object.new(360, "ShMiiObj02"),
      "ShMiiObj03" => Object.new(361, "ShMiiObj03"),
      "Hanabi" => Object.new(362, "point"),
      "miiposter" => Object.new(363, "miiposter"),
      "dk_miiobj00" => Object.new(364, "dk_miiobj00"),
      "light_house" => Object.new(365, "light_house"),
      "r_parasol" => Object.new(366, "r_parasol"),
      "obakeblock2SFCc" => Object.new(367, "obakeblockSFC"),
      "obakeblock3SFCc" => Object.new(368, "obakeblockSFC"),
      "koopaFigure" => Object.new(369, "koopaFigure"),
      "pukupuku" => Object.new(370, "pukupuku"),
      "v_stand1" => Object.new(371, "point"),
      "v_stand2" => Object.new(372, "point"),
      "leaf_effect" => Object.new(373, "point"),
      "karehayama" => Object.new(374, "karehayama"),
      "EarthRing" => Object.new(375, "EarthRing"),
      "SpaceSun" => Object.new(376, "SpaceSun"),
      "BlackHole" => Object.new(377, "point"),
      "StarRing" => Object.new(378, "StarRing"),
      "M_obj_kanban" => Object.new(379, "M_obj_kanban"),
      "MiiStatueL1" => Object.new(380, "MiiStatueL1"),
      "MiiStatueD1" => Object.new(381, "MiiStatueD1"),
      "MiiSphinxY1" => Object.new(382, "point"),
      "MiiSphinxY2" => Object.new(383, "MiiSphinxY2"),
      "FlagA5" => Object.new(384, "FlagA5"),
      "CarB" => Object.new(385, "CarB"),
      "FlagA4" => Object.new(386, "point"),
      "Steam" => Object.new(387, "point"),
      "Alarm" => Object.new(388, "point"),
      "group_monte_a" => Object.new(389, "group_monte_a"),
      "MiiStatueL2" => Object.new(390, "MiiStatueL2"),
      "MiiStatueD2" => Object.new(391, "MiiStatueD2"),
      "MiiStatueP1" => Object.new(392, "MiiStatueP1"),
      "SentakuDS" => Object.new(393, "SentakuDS"),
      "fks_screen_wii" => Object.new(394, "fks_screen_wii"),
      "KoopaFigure64" => Object.new(395, "KoopaFigure64"),
      "b_teresa" => Object.new(396, "b_teresa"),
      "MiiStatueDK1" => Object.new(397, "point"),
      "MiiKanban" => Object.new(398, "MiiKanban"),
      "BGteresaSFC" => Object.new(399, "BGteresaSFC"),
      "kuribo" => Object.new(401, "kuribo"),
      "choropu" => Object.new(402, "choropu"),
      "cow" => Object.new(403, "cow"),
      "pakkun_f" => Object.new(404, "pakkun_f"),
      "WLfirebarGC" => Object.new(405, "WLfirebarGC"),
      "wanwan" => Object.new(406, "wanwan"),
      "poihana" => Object.new(407, "poihana"),
      "DKrockGC" => Object.new(408, "DKrockGC"),
      "sanbo" => Object.new(409, "sanbo"),
      "choropu2" => Object.new(410, "choropu"),
      "TruckWagon" => Object.new(411, "TruckWagon"),
      "heyho" => Object.new(412, "heyho"),
      "Press" => Object.new(413, "Press"),
      "Press_soko" => Object.new(414, "point"),
      "pile" => Object.new(415, "point"),
      "choropu_ground" => Object.new(416, "point"),
      "WLfireringGC" => Object.new(417, "WLfirebarGC"),
      "pakkun_dokan" => Object.new(418, "pakkun_dokan"),
      "begoman_spike" => Object.new(419, "begoman_spike"),
      "FireSnake" => Object.new(420, "FireSnake"),
      "koopaFirebar" => Object.new(421, "point"),
      "Epropeller" => Object.new(422, "Epropeller"),
      "dc_pillar_c" => Object.new(423, "point"),
      "FireSnake_v" => Object.new(424, "FireSnake"),
      "honeBall" => Object.new(425, "honeBall"),
      "puchi_pakkun" => Object.new(426, "puchi_pakkun"),
      "sanbo_big" => Object.new(427, "sanbo"),
      "kinoko_ud" => Object.new(501, "kinoko"),
      "kinoko_bend" => Object.new(502, "kinoko"),
      "VolcanoRock1" => Object.new(503, "VolcanoRock1"),
      "bulldozer_left" => Object.new(504, "bulldozer_left"),
      "bulldozer_right" => Object.new(505, "bulldozer_right"),
      "kinoko_nm" => Object.new(506, "kinoko"),
      "Crane" => Object.new(507, "Crane"),
      "VolcanoPiece" => Object.new(508, "VolcanoPiece1"),
      "FlamePole" => Object.new(509, "FlamePole"),
      "TwistedWay" => Object.new(510, "TwistedWay"),
      "TownBridgeDSc" => Object.new(511, "TownBridgeDS"),
      "DKship64" => Object.new(512, "point"),
      "kinoko_kuki" => Object.new(513, "point"),
      "DKturibashiGCc" => Object.new(514, "DKturibashiGC"),
      "FlamePoleEff" => Object.new(515, "point"),
      "aurora" => Object.new(516, "aurora"),
      "venice_saku" => Object.new(517, "venice_saku"),
      "casino_roulette" => Object.new(518, "casino_roulette"),
      "BossField01_OBJ1" => Object.new(519, "point"),
      "dc_pillar" => Object.new(520, "dc_pillar"),
      "dc_sandcone" => Object.new(521, "dc_sandcone"),
      "venice_hasi" => Object.new(522, "venice_hasi"),
      "venice_gondola" => Object.new(523, "point"),
      "quicksand" => Object.new(524, "point"),
      "bblock" => Object.new(525, "point"),
      "ami" => Object.new(526, "ami"),
      "M_obj_jump" => Object.new(527, "point"),
      "starGate" => Object.new(528, "point"),
      "RM_ring1" => Object.new(529, "RM_ring1"),
      "FlamePole_v" => Object.new(530, "FlamePole_v"),
      "M_obj_s_jump" => Object.new(531, "point"),
      "InsekiA" => Object.new(532, "InsekiA"),
      "InsekiB" => Object.new(533, "InsekiB"),
      "FlamePole_v_big" => Object.new(534, "point"),
      "Mdush" => Object.new(535, "Mdush"),
      "HP_pipe" => Object.new(536, "point"),
      "DemoCol" => Object.new(537, "DemoCol"),
      "M_obj_s_jump2" => Object.new(538, "point"),
      "M_obj_jump2" => Object.new(539, "point"),
      "DonkyCannonGC" => Object.new(601, "DonkyCannonGC"),
      "BeltEasy" => Object.new(602, "BeltEasy"),
      "BeltCrossing" => Object.new(603, "BeltCrossing"),
      "BeltCurveA" => Object.new(604, "BeltCurveA"),
      "BeltCurveB" => Object.new(605, "point"),
      "escalator" => Object.new(606, "escalator"),
      "DonkyCannon_wii" => Object.new(607, "DonkyCannon_wii"),
      "escalator_group" => Object.new(608, "point"),
      "tree_cannon" => Object.new(609, "tree_cannon"),
      "group_enemy_b" => Object.new(701, "group_enemy_b"),
      "group_enemy_c" => Object.new(702, "group_enemy_c"),
      "taimatsu" => Object.new(703, "point"),
      "truckChimSmkW" => Object.new(704, "truckChimSmkW"),
      "Mstand" => Object.new(705, "point"),
      "dkmonitor" => Object.new(706, "dkmonitor"),
      "group_enemy_a" => Object.new(707, "group_enemy_a"),
      "FlagB3" => Object.new(708, "FlagB3"),
      "spot" => Object.new(709, "spot"),
      "group_enemy_d" => Object.new(710, "point"),
      "FlagB4" => Object.new(711, "FlagB4"),
      "group_enemy_e" => Object.new(712, "group_enemy_e"),
      "group_monte_L" => Object.new(713, "group_monte_a"),
      "group_enemy_f" => Object.new(714, "group_enemy_f"),
      "FallBsA" => Object.new(715, "point"),
      "FallBsB" => Object.new(716, "point"),
      "FallBsC" => Object.new(717, "point"),
      "volsmk" => Object.new(718, "point"),
      "ridgemii00" => Object.new(719, "ridgemii00"),
      "Flash_L" => Object.new(720, "point"),
      "Flash_B" => Object.new(721, "point"),
      "Flash_W" => Object.new(722, "point"),
      "Flash_M" => Object.new(723, "point"),
      "Flash_S" => Object.new(724, "point"),
      "MiiSignNoko" => Object.new(725, "MiiSignNoko"),
      "UtsuboDokan" => Object.new(726, "UtsuboDokan"),
      "Spot64" => Object.new(727, "Spot64"),
      "DemoEf" => Object.new(728, "point"),
      "Fall_MH" => Object.new(729, "point"),
      "Fall_Y" => Object.new(730, "point"),
      "DemoJugemu" => Object.new(731, "DemoJugemu"),
      "group_enemy_a_demo" => Object.new(732, "group_enemy_a_demo"),
      "group_monte_a_demo" => Object.new(733, "group_monte_a_demo"),
      "volfall" => Object.new(734, "point"),
      "MiiStatueM2" => Object.new(735, "MiiStatueM2"),
      "RhMiiKanban" => Object.new(736, "RhMiiKanban"),
      "MiiStatueL3" => Object.new(737, "MiiStatueL3"),
      "MiiSignWario" => Object.new(738, "MiiSignWario"),
      "MiiStatueBL1" => Object.new(739, "MiiStatueBL1"),
      "MiiStatueBD1" => Object.new(740, "MiiStatueBD1"),
      "Kamifubuki" => Object.new(741, "point"),
      "Crescent64" => Object.new(742, "Crescent64"),
      "MiiSighKino" => Object.new(743, "MiiSighKino"),
      "MiiObjD01" => Object.new(744, "MiiObjD01"),
      "MiiObjD02" => Object.new(745, "MiiObjD02"),
      "MiiObjD03" => Object.new(746, "MiiObjD03"),
      "mare_a" => Object.new(747, "mare_a"),
      "mare_b" => Object.new(748, "mare_b"),
      "EnvKareha" => Object.new(749, "point"),
      "EnvFire" => Object.new(750, "point"),
      "EnvSnow" => Object.new(751, "point"),
      "M_obj_start" => Object.new(752, "point"),
      "EnvKarehaUp" => Object.new(753, "point"),
      "M_obj_kanban_y" => Object.new(754, "point"),
      "DKfalls" => Object.new(755, "point")
    }
  end
end
