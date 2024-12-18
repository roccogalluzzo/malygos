defmodule Malygos.Login.LoginServer do
  use ThousandIsland.Handler

  require Logger
  # https://shadowburn-project.org/2018/10/17/logging-in-with-vanilla.html

  # <<0x3, 0x22, 0x0, 0x57, 0x6F, 0x57, 0x0, 0x1, 0xC, 0x1, 0xF3, 0x16, 0x36, 0x38, 0x78, 0x0, 0x6E, 0x69, 0x57, 0x0, 0x42, 0x47, 0x6E, 0x65, 0x3C, 0x0, 0x0, 0x0, 0xC0, 0xA8, 0xB2, 0x2B, 0x4, 0x54, 0x45, 0x53, 0x54>>

  # 0x00	uint8	command	0x00
  # 0x01	uint8	error
  # 0x02	uint16	packet size	Length of the packet, minus 4 (the size of command, error, and packet size)
  # 0x04	char[4]	game	‘WoW’
  # 0x08	uint8[3]	version	0x01 0x01 0x02
  # 0x0B	uint16	build	4125
  # 0x0D	char[4]	platform	eg. ‘x86’
  # 0x11	char[4]	os	eg. ‘Win’
  # 0x15	char[4]	country	eg. ‘enUS’
  # 0x19	uint32	worldregion_bias	offset in minutes from UTC time, eg. 180 means 180 minutes
  # 0x1D	uint32	ip
  # 0x21	uint8	account_name_length
  # 0x22	char[account_name_length]	account_name

  def handle_data(
        <<0, packet_size::little-size(16)>>,
        socket,
        state
      ) do
    Logger.error("packet_size: #{inspect(packet_size, base: :hex)}")
    ThousandIsland.Socket.send(socket, <<0, 0, 5>>)
    {:close, state}
  end

  @impl ThousandIsland.Handler
  def handle_data(<<opcode, packet::binary>>, socket, state) do
    Logger.error("????: #{inspect(packet, base: :hex)}")
    ThousandIsland.Socket.send(socket, <<0, 0, 5>>)
    {:close, state}
  end
end
