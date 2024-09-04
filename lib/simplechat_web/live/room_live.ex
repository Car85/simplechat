defmodule SimplechatWeb.RoomLive do
  use SimplechatWeb, :live_view
  require Logger

  @colors ["color-1", "color-2", "color-3", "color-4", "color-5", "color-6", "color-7", "color-8",
           "color-9", "color-10", "color-11", "color-12", "color-13", "color-14", "color-15", "color-16",
           "color-17", "color-18", "color-19", "color-20", "color-21", "color-22", "color-23", "color-24",
           "color-25", "color-26", "color-27", "color-28", "color-29", "color-30"]



  @emojis [
    "😀", "😁", "😂", "🤣", "😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎", "😍", "😘", "😗",
    "😙", "😚", "🙂", "🤗", "🤩", "🤔", "🤨", "😐", "😑", "😶", "🙄", "😏", "😣", "😥", "😮",
    "🤐", "😯", "😪", "😫", "🥱", "😴", "😌", "😛", "😜", "😝", "🤤", "😒", "😓", "😔", "😕",
    "🙃", "🤑", "😲", "☹️", "🙁", "😖", "😞", "😟", "😤", "😢", "😭", "😦", "😧", "😨", "😩",
    "🤯", "😬", "😰", "😱", "🥵", "🥶", "😳", "🤪", "😵", "😡", "😠", "🤬", "😷", "🤒", "🤕",
    "🤢", "🤮", "🤧", "😇", "🥳", "🥺", "🤠", "🤡", "🤥", "🤫", "🤭", "🧐", "🤓", "😈", "👿",
    "👹", "👺", "💀", "☠️", "👻", "👽", "👾", "🤖", "😺", "😸", "😹", "😻", "😼", "😽", "🙀",
    "😿", "😾", "🙈", "🙉", "🙊", "💋", "💌", "💘", "💝", "💖", "💗", "💓", "💞", "💕", "💟",
    "❣️", "💔", "❤️", "🧡", "💛", "💚", "💙", "💜", "🤎", "🖤", "🤍", "💯", "💢", "💥", "💫",
    "💦", "💨", "🕳️", "💣", "💬", "👁️‍🗨️", "🗨️", "🗯️", "💭", "💤", "👋", "🤚", "🖐️", "✋",
    "🖖", "👌", "🤌", "🤏", "✌️", "🤞", "🤟", "🤘", "🤙", "👈", "👉", "👆", "🖕", "👇", "☝️",
    "👍", "👎", "✊", "👊", "🤛", "🤜", "👏", "🙌", "👐", "🤲", "🤝", "🙏", "✍️", "💅", "🤳",
    "💪", "🦾", "🦿", "🦵", "🦶", "👂", "🦻", "👃", "🧠", "🦷", "🦴", "👀", "👁️", "👅", "👄",
    "🧑‍🦰", "🧑‍🦱", "🧑‍🦳", "🧑‍🦲", "👶", "🧒", "👦", "👧", "🧑", "👱", "👨", "🧔", "👨‍🦰",
    "👨‍🦱", "👨‍🦳", "👨‍🦲", "👩", "👩‍🦰", "👩‍🦱", "👩‍🦳", "👩‍🦲", "🧓", "👴", "👵", "🙍",
    "🙍‍♂️", "🙍‍♀️", "🙎", "🙎‍♂️", "🙎‍♀️", "🙅", "🙅‍♂️", "🙅‍♀️", "🙆", "🙆‍♂️", "🙆‍♀️",
    "💁", "💁‍♂️", "💁‍♀️", "🙋", "🙋‍♂️", "🙋‍♀️", "🧏", "🧏‍♂️", "🧏‍♀️", "🙇", "🙇‍♂️", "🙇‍♀️",
    "🤦", "🤦‍♂️", "🤦‍♀️", "🤷", "🤷‍♂️", "🤷‍♀️", "🧑‍⚕️", "👨‍⚕️", "👩‍⚕️", "🧑‍🎓", "👨‍🎓",
    "👩‍🎓", "🧑‍🏫", "👨‍🏫", "👩‍🏫", "🧑‍⚖️", "👨‍⚖️", "👩‍⚖️", "🧑‍🌾", "👨‍🌾", "👩‍🌾", "🧑‍🍳",
    "👨‍🍳", "👩‍🍳", "🧑‍🔧", "👨‍🔧", "👩‍🔧", "🧑‍🏭", "👨‍🏭", "👩‍🏭", "🧑‍💼", "👨‍💼", "👩‍💼",
    "🧑‍🔬", "👨‍🔬", "👩‍🔬", "🧑‍💻", "👨‍💻", "👩‍💻", "🧑‍🎤", "👨‍🎤", "👩‍🎤", "🧑‍🎨", "👨‍🎨",
    "👩‍🎨", "🧑‍✈️", "👨‍✈️", "👩‍✈️", "🧑‍🚀", "👨‍🚀", "👩‍🚀", "🧑‍🚒", "👨‍🚒", "👩‍🚒", "👮",
    "👮‍♂️", "👮‍♀️", "🕵️", "🕵️‍♂️", "🕵️‍♀️", "💂", "💂‍♂️", "💂‍♀️", "🥷", "👷", "👷‍♂️",
    "👷‍♀️", "🤴", "👸", "👳", "👳‍♂️", "👳‍♀️", "👲", "🧕", "🤵", "🤵‍♂️", "🤵‍♀️", "👰", "👰‍♂️",
    "👰‍♀️", "🤰", "🤱", "👩‍🍼", "👨‍🍼", "🧑‍🍼", "🙇", "🙇‍♂️", "🙇‍♀️", "🧎", "🧎‍♂️", "🧎‍♀️",
    "💇", "💇‍♂️", "💇‍♀️", "💆", "💆‍♂️", "💆‍♀️", "🧖", "🧖‍♂️", "🧖‍♀️", "🧘", "🧑‍🤝‍🧑",
    "👭", "👫", "👬", "💏", "👩‍❤️‍💋‍👨", "👨‍❤️‍💋‍👨", "👩‍❤️‍💋‍👩", "💑", "👩‍❤️‍👨", "👨‍❤️‍👨",
    "👩‍❤️‍👩", "👪", "👨‍👩‍👦", "👨‍👩‍👧", "👨‍👩‍👧‍👦", "👨‍👩‍👦‍👦", "👨‍👩‍👧‍👧", "👨‍👨‍👦",
    "👨‍👨‍👧", "👨‍👨‍👧‍👦", "👨‍👨‍👦‍👦", "👨‍👨‍👧‍👧", "👩‍👩‍👦", "👩‍👩‍👧", "👩‍👩‍👧‍👦",
    "👩‍👩‍👦‍👦", "👩‍👩‍👧‍👧", "🗣️", "👤", "👥", "🫂", "👣", "🧳", "🌂", "☂️", "🧵", "🧶",
    "👓", "🕶️", "🥽", "🥼", "🦺", "👔", "👕", "👖", "🧣", "🧤", "🧥", "🧦", "👗", "👘", "🥻",
    "🩱", "🩲", "🩳", "👙", "👚", "👛", "👜", "👝", "🎒", "👞", "👟", "🥾", "🥿", "👠", "👡",
    "🩰", "👢", "👑", "👒", "🎩", "🎓", "🧢", "🪖", "⛑️", "📿", "💄", "💍", "💎", "🐵", "🐒",
    "🦍", "🦧", "🐶", "🐕", "🦮", "🐕‍🦺", "🐩", "🐺", "🦊", "🦝", "🐱", "🐈", "🦁", "🐯", "🐅",
    "🐆", "🐴", "🐎", "🦄", "🦓", "🦌", "🦬", "🐮", "🐂", "🐃", "🐄", "🐷", "🐖", "🐗", "🐽",
    "🐏", "🐑", "🐐", "🐪", "🐫", "🦙", "🦒", "🐘", "🦣", "🦏", "🦛", "🐭", "🐁", "🐀", "🐹",
    "🐰", "🐇", "🐿️", "🦫", "🦔", "🦇", "🐻", "🐻‍❄️", "🐨", "🐼", "🦥", "🦦", "🦨", "🦘",
    "🦡", "🐾", "🦃", "🐔", "🐓", "🐣", "🐤", "🐥", "🐦", "🐧", "🕊️", "🦅", "🦆", "🦢", "🦉",
    "🦤", "🪶", "🦩", "🦚", "🦜", "🐸", "🐊", "🐢", "🦎", "🐍", "🐲", "🐉", "🦕", "🦖", "🐳",
    "🐋", "🐬", "🦭", "🐟", "🐠", "🐡", "🦈", "🐙", "🐚", "🪸", "🪷", "🐌", "🦋", "🐛", "🐜",
    "🐝", "🪲", "🐞", "🦗", "🪳", "🦟", "🦠", "💐", "🌸", "💮", "🪷", "🏵️", "🌹", "🥀", "🌺",
    "🌻", "🌼", "🌷", "🌱", "🪴", "🌲", "🌳", "🌴", "🌵", "🌾", "🌿", "☘️", "🍀", "🍁", "🍂",
    "🍃", "🪹", "🪺", "🍄", "🐚", "🪵", "🪨", "💧", "🌊", "🔥", "💦", "🌪️", "🌈", "🌤️", "🌥️",
    "🌦️", "🌧️", "🌨️", "☁️", "⛅", "🌡️", "🌩️", "⚡", "❄️", "☃️", "⛄", "☄️", "💥", "💫",
    "💨", "🌀", "🌟", "🌠", "🌌", "🌙", "🌚", "🌛", "🌜", "☀️", "🌝", "🪐", "⭐", "🌞", "🌍",
    "🌎", "🌏", "🌐", "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘", "🌙", "🌚", "🌛", "🌜",
    "🌝", "☀️", "🌞", "⭐", "🌟", "🌠", "☁️", "⛅", "⛈️", "🌤️", "🌥️", "🌦️", "🌧️", "🌨️",
    "🌩️", "🌪️", "🌫️", "🌬️", "🌀", "🌈", "🌂", "☂️", "☔", "⛱️", "⚡", "❄️", "☃️", "⛄",
    "☄️", "🔥", "💧", "🌊", "💦", "🌟", "🎋", "🎍", "🎎", "🎏", "🎐", "🎑", "🎀", "🎁",
    "🎗️", "🎖️", "🎗️", "🎖️", "🎗️", "🎖️", "🎗️", "🎖️"
  ]
  @impl true
  def mount(%{"id" => room_id}, _session, socket) do
    topic = "room:" <> room_id
    username = MnemonicSlugs.generate_slug(2)
    user_color_class = Enum.random(@colors)
    theme = "light" # Default theme

    if connected?(socket) do
      SimplechatWeb.Endpoint.subscribe(topic)
      SimplechatWeb.Presence.track(self(), topic, username, %{color_class: user_color_class})
    end

    current_users = SimplechatWeb.Presence.list(topic)
    user_colors = Enum.into(current_users, %{}, fn {user, meta} -> {user, meta[:metas] |> List.first() |> Map.get(:color_class, "color-default")} end)
    user_list = Map.keys(user_colors)

    {:ok,
     assign(socket,
       room_id: room_id,
       topic: topic,
       new_message: "",
       username: username,
       user_color_class: user_color_class,
       theme: theme,
       messages: [%{uuid: UUID.uuid4(), content: "Welcome to SimpleChat #{username}", username: "system", color_class: "color-default"}],
       user_list: user_list,
       user_colors: user_colors,
       emojis: @emojis,
       selected_emoji: nil,
       show_emoji_list: false,
       temporary_assigns: [messages: []]
     )
    }
  end

  @impl true
  def handle_event("toggle_theme", _, socket) do
    new_theme = if socket.assigns.theme == "light", do: "dark", else: "light"
    {:noreply, assign(socket, theme: new_theme)}
  end

  @impl true
  def handle_event("submit_message", %{"message" => message}, socket) do
    message_content =
        if socket.assigns.selected_emoji && message == "" do
          socket.assigns.selected_emoji
        else
          message
        end
     message = %{uuid: UUID.uuid4(), content: message_content, username: socket.assigns.username, color_class: socket.assigns.user_color_class}
    SimplechatWeb.Endpoint.broadcast(socket.assigns.topic, "new-message", message)
    {:noreply, assign(socket, new_message: "")}
  end

  @impl true
  def handle_event("form_update", %{"message" => message}, socket) do
    {:noreply, assign(socket, new_message: message)}
  end

  @impl true
  def handle_event("toggle_emoji_list", _params, socket) do
    {:noreply, assign(socket, :show_emoji_list, !socket.assigns.show_emoji_list)}
  end

  @impl true
  def handle_event("select_emoji", %{"emoji" => emoji}, socket) do
    new_message = socket.assigns.new_message <> emoji
    {:noreply, assign(socket, new_message: new_message, selected_emoji: emoji, show_emoji_list: false)}
  end

  @impl true
  def handle_info(%{event: "new-message", payload: message}, socket) do
    message = Map.put_new(message, :color_class, "color-default")
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

  @impl true
  def handle_info(%{event: "presence_diff", payload: %{joins: joins, leaves: leaves}}, socket) do
    join_messages =
      joins
      |> Map.keys()
      |> Enum.map(fn username -> %{type: :system, uuid: UUID.uuid4(), content: "#{username} joined", color_class: "color-default"} end)

    leave_messages =
      leaves
      |> Map.keys()
      |> Enum.map(fn username -> %{type: :system, uuid: UUID.uuid4(), content: "#{username} left", color_class: "color-default"} end)

    user_colors = socket.assigns.user_colors
    user_colors = Enum.reduce(joins, user_colors, fn {user, meta}, acc -> Map.put(acc, user, meta[:metas] |> List.first() |> Map.get(:color_class, "color-default")) end)
    user_colors = Enum.reduce(leaves, user_colors, fn user, acc -> Map.delete(acc, user) end)

    user_list = Map.keys(user_colors)

    new_messages = join_messages ++ leave_messages
    {:noreply, assign(socket, messages: socket.assigns.messages ++ new_messages, user_list: user_list, user_colors: user_colors)}
  end

  def display_message(%{type: :system, uuid: uuid, content: content, color_class: color_class}) do
    assigns = %{uuid: uuid, content: content, color_class: color_class}
    ~H"""
    <p id={uuid} class={color_class}><em> <%= content %> </em></p>
    """
  end

  def display_message(%{uuid: uuid, content: content, username: username, color_class: color_class}) do
    assigns = %{uuid: uuid, content: content, username: username, color_class: color_class}
    ~H"""
    <p id={uuid} class={color_class}><strong> <%= username %> </strong> <%= content %> </p>
    """
  end
end
