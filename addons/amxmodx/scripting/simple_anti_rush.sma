#include <amxmodx>
#include <reapi>

new g_msgRoundTime
new g_antiRushTime

new Float: g_freezeTime

public plugin_init() {
  register_plugin("Simple anti rush", "1.0.0", "ufame")

  register_dictionary("simple_anti_rush.txt")

  g_msgRoundTime = get_user_msgid("RoundTime")

  bind_pcvar_num(create_cvar("anti_rush_time", "3", _, "Anti rush (freeze) time for CT"), g_antiRushTime)
  AutoExecConfig()

  RegisterHookChain(RG_CBasePlayer_Spawn, "cbasePlayerSpawn_Post", true)
  RegisterHookChain(RG_CSGameRules_OnRoundFreezeEnd, "gameRulesFreezeEnd_Post", true)
}

//reconnect?
public cbasePlayerSpawn_Post(id) {
  if (!is_user_alive(id) || get_member(id, m_iTeam) != TEAM_CT)
    return

  if ((g_freezeTime + float(g_antiRushTime)) > get_gametime())
    userFreeze(id)
}

public gameRulesFreezeEnd_Post() {
  sendTimer(g_antiRushTime)
  g_freezeTime = get_gametime()

  for (new id = 1; id <= MaxClients; id++) {
    if (!is_user_alive(id) || get_member(id, m_iTeam) != TEAM_CT)
      continue
    
    userFreeze(id)
  }

  client_print_color(0, print_team_default, "%L", LANG_PLAYER, "SAR_CT_FROZEN", g_antiRushTime)

  set_task(float(g_antiRushTime), "taskUnfreezeAll")
}

public taskUnfreezeAll() {
  for (new id = 1; id <= MaxClients; id++) {
    if (!is_user_alive(id) || get_member(id, m_iTeam) != TEAM_CT)
      continue
    
    userUnFreeze(id)
  }

  client_print_color(0, print_team_default, "%L", LANG_PLAYER, "SAR_CT_UNFROZEN")

  sendTimer(get_member_game(m_iRoundTime) - g_antiRushTime)
}

userFreeze(const id) {
  set_entvar(id, var_maxspeed, 0.001)
  set_member(id, m_bIsDefusing, true)
}

userUnFreeze(const id) {
  rg_reset_maxspeed(id)
  set_member(id, m_bIsDefusing, false)
}

sendTimer(time) {
  message_begin(MSG_ALL, g_msgRoundTime)
  write_short(time)
  message_end()
}
