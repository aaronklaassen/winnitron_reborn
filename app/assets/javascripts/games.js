(function(window, $, undefined) {

  $(function() {
    $(".add_nested_fields_link").click();

    $(".popular-tags .js-add-tag").click(function(e) {
      e.preventDefault();
      var field = $(".js-tag-list")
      field.tagsinput("add", $(this).attr("href"))
    })

    $("#zipfile-uploader").bind("s3_upload_complete", function(e, content) {
      $(".next-step").removeClass("disabled");
    });


    $(".template-select select").change(function(e) {
      if ($(this).val() == "custom") {
        $(".custom-warning").css("visibility", "visible");
      } else {
        $(".custom-warning").css("visibility", "hidden");
      }
    });

    $(".template-select button.apply-template").click(function(e) {
      e.preventDefault();

      var template = $("select.template").val();

      if (template == "custom")
        return;

      $.get("/key_maps", function(templates) {
        var keyMap = templates[template];

        for (var p = 1; p <= 4; p++) {
          for (var control in keyMap[p]) {
            var key = keyMap[p][control];
            $(".player" + p + " ." + control + " a.ahk-key").html(key);
          }
        }

        highlightKeyboard();
      });

    });


    highlightKeyboard();

    document.querySelector("body").onkeydown = function(e) {
      if (!e.metaKey) {
        e.preventDefault();
      }

      var key = keyCodeToAHK(e.keyCode);
      if (key.ahk != undefined)
        $(".modal.select-key-modal.in .custom-key-display").html(key.ahk);
    }
  });

  function resetKeyboard() {
    $("#keyboard li.symbol, #keyboard li.letter").css("background-color", "#f0f0f0");
    $("#keyboard li.symbol, #keyboard li.letter").css("color", "black");
  }

  function highlightKeyboard() {
    resetKeyboard();

    colors = [undefined,
      "#404cbf",
      "#bf4055",
      "#46bf40",
      "#bfb640"
    ];

    for(var player = 1; player <= 4; player++) {
      $(".player" + player + " a.ahk-key").each(function(i, element) {
        var key = element.text.trim();
        $("#keyboard li[data-ahk='" + key + "'").css("background-color", colors[player]);
        $("#keyboard li[data-ahk='" + key + "'").css("color", "white");
      });
    }
  }

  function keyCodeToAHK(keyCode) {
    var key = KEY_TRANSLATION["keys"].filter(function(map) {
      return map.keycode == keyCode;
    });

    if (key[0] === undefined) {
      console.warn("Unknown keyCode: " + keyCode);
      return {
        name: null,
        ahk: null
      }
    } else {
      return key[0];
    }
  }

})(window, jQuery)

// TODO: move this out of here.
const KEY_TRANSLATION = {
  "meta": {
    "source": "url"
  },
  "keys": [
    {
      "name": "Numpad0",
      "ahk": "Numpad0",
      "keycode": null,
      "unity": "Keypad0"
    },
    {
      "name": "Numpad1",
      "ahk": "Numpad1",
      "keycode": null,
      "unity": "Keypad1"
    },
    {
      "name": "Numpad2",
      "ahk": "Numpad2",
      "keycode": null,
      "unity": "Keypad2"
    },
    {
      "name": "Numpad3",
      "ahk": "Numpad3",
      "keycode": null,
      "unity": "Keypad3"
    },
    {
      "name": "Numpad4",
      "ahk": "Numpad4",
      "keycode": null,
      "unity": "Keypad4"
    },
    {
      "name": "Numpad5",
      "ahk": "Numpad5",
      "keycode": null,
      "unity": "Keypad5"
    },
    {
      "name": "Numpad6",
      "ahk": "Numpad6",
      "keycode": null,
      "unity": "Keypad6"
    },
    {
      "name": "Numpad7",
      "ahk": "Numpad7",
      "keycode": null,
      "unity": "Keypad7"
    },
    {
      "name": "Numpad8",
      "ahk": "Numpad8",
      "keycode": null,
      "unity": "Keypad8"
    },
    {
      "name": "Numpad9",
      "ahk": "Numpad9",
      "keycode": null,
      "unity": "Keypad9"
    },
    {
      "name": "NumpadDot",
      "ahk": "NumpadDot",
      "keycode": null,
      "unity": "KeypadPeriod"
    },
    {
      "name": "NumpadDiv",
      "ahk": "NumpadDiv",
      "keycode": null,
      "unity": "KeypadDivide"
    },
    {
      "name": "NumpadMult",
      "ahk": "NumpadMult",
      "keycode": null,
      "unity": "KeypadMultiply"
    },
    {
      "name": "NumpadSub",
      "ahk": "NumpadSub",
      "keycode": null,
      "unity": "KeypadMinus"
    },
    {
      "name": "NumpadAdd",
      "ahk": "NumpadAdd",
      "keycode": null,
      "unity": "KeypadPlus"
    },
    {
      "name": "NumpadEnter",
      "ahk": "NumpadEnter",
      "keycode": null,
      "unity": "KeypadEnter"
    },
    {
      "name": "LControl",
      "ahk": "LControl",
      "keycode": 17,
      "unity": "LeftControl"
    },
    {
      "name": "RControl",
      "ahk": "RControl",
      "keycode": null,
      "unity": "RightControl"
    },
    {
      "name": "LShift",
      "ahk": "LShift",
      "keycode": 16,
      "unity": "LeftShift"
    },
    {
      "name": "RShift",
      "ahk": "RShift",
      "keycode": 16,
      "unity": "RightShift"
    },
    {
      "name": "LAlt",
      "ahk": "LAlt",
      "keycode": 18,
      "unity": "LeftAlt"
    },
    {
      "name": "RAlt",
      "ahk": "RAlt",
      "keycode": 18,
      "unity": "RightAlt"
    },
    {
      "name": "Delete",
      "ahk": "Delete",
      "keycode": null,
      "unity": "Delete"
    },
    {
      "name": "Insert",
      "ahk": "Insert",
      "keycode": null,
      "unity": "Insert"
    },
    {
      "name": "Home",
      "ahk": "Home",
      "keycode": null,
      "unity": "Home"
    },
    {
      "name": "End",
      "ahk": "End",
      "keycode": null,
      "unity": "End"
    },
    {
      "name": "PgUp",
      "ahk": "PgUp",
      "keycode": null,
      "unity": "PageUp"
    },
    {
      "name": "PgDn",
      "ahk": "PgDn",
      "keycode": null,
      "unity": "PageDown"
    },
    {
      "name": "Up",
      "ahk": "Up",
      "keycode": 38,
      "unity": "UpArrow"
    },
    {
      "name": "Down",
      "ahk": "Down",
      "keycode": 40,
      "unity": "DownArrow"
    },
    {
      "name": "Left",
      "ahk": "Left",
      "keycode": 37,
      "unity": "LeftArrow"
    },
    {
      "name": "Right",
      "ahk": "Right",
      "keycode": 39,
      "unity": "RightArrow"
    },
    {
      "name": "Space",
      "ahk": "Space",
      "keycode": 32,
      "unity": "Space"
    },
    {
      "name": "Tab",
      "ahk": "Tab",
      "keycode": 9,
      "unity": "Tab"
    },
    {
      "name": "Backspace",
      "ahk": "Backspace",
      "keycode": 8,
      "unity": "Backspace"
    },
    { // TODO: are these correct?
      "name": "Enter",
      "ahk": "Enter",
      "keycode": 13,
      "unity": "Enter"
    },
    {
      "name": "a",
      "ahk": "a",
      "keycode": 65,
      "unity": "A"
    },
    {
      "name": "b",
      "ahk": "b",
      "keycode": 66,
      "unity": "B"
    },
    {
      "name": "c",
      "ahk": "c",
      "keycode": 67,
      "unity": "C"
    },
    {
      "name": "d",
      "ahk": "d",
      "keycode": 68,
      "unity": "D"
    },
    {
      "name": "e",
      "ahk": "e",
      "keycode": 69,
      "unity": "E"
    },
    {
      "name": "f",
      "ahk": "f",
      "keycode": 70,
      "unity": "F"
    },
    {
      "name": "g",
      "ahk": "g",
      "keycode": 71,
      "unity": "G"
    },
    {
      "name": "h",
      "ahk": "h",
      "keycode": 72,
      "unity": "H"
    },
    {
      "name": "i",
      "ahk": "i",
      "keycode": 73,
      "unity": "I"
    },
    {
      "name": "j",
      "ahk": "j",
      "keycode": 74,
      "unity": "J"
    },
    {
      "name": "k",
      "ahk": "k",
      "keycode": 75,
      "unity": "K"
    },
    {
      "name": "l",
      "ahk": "l",
      "keycode": 76,
      "unity": "L"
    },
    {
      "name": "m",
      "ahk": "m",
      "keycode": 77,
      "unity": "M"
    },
    {
      "name": "n",
      "ahk": "n",
      "keycode": 78,
      "unity": "N"
    },
    {
      "name": "o",
      "ahk": "o",
      "keycode": 79,
      "unity": "O"
    },
    {
      "name": "p",
      "ahk": "p",
      "keycode": 80,
      "unity": "P"
    },
    {
      "name": "q",
      "ahk": "q",
      "keycode": 81,
      "unity": "Q"
    },
    {
      "name": "r",
      "ahk": "r",
      "keycode": 82,
      "unity": "R"
    },
    {
      "name": "s",
      "ahk": "s",
      "keycode": 83,
      "unity": "S"
    },
    {
      "name": "t",
      "ahk": "t",
      "keycode": 84,
      "unity": "T"
    },
    {
      "name": "u",
      "ahk": "u",
      "keycode": 85,
      "unity": "U"
    },
    {
      "name": "v",
      "ahk": "v",
      "keycode": 86,
      "unity": "V"
    },
    {
      "name": "w",
      "ahk": "w",
      "keycode": 87,
      "unity": "W"
    },
    {
      "name": "x",
      "ahk": "x",
      "keycode": 88,
      "unity": "X"
    },
    {
      "name": "y",
      "ahk": "y",
      "keycode": 89,
      "unity": "Y"
    },
    {
      "name": "z",
      "ahk": "z",
      "keycode": 90,
      "unity": "Z"
    },
    {
      "name": "0",
      "ahk": "0",
      "keycode": 48,
      "unity": "Alpha0"
    },
    {
      "name": "1",
      "ahk": "1",
      "keycode": 49,
      "unity": "Alpha1"
    },
    {
      "name": "2",
      "ahk": "2",
      "keycode": 50,
      "unity": "Alpha2"
    },
    {
      "name": "3",
      "ahk": "3",
      "keycode": 51,
      "unity": "Alpha3"
    },
    {
      "name": "4",
      "ahk": "4",
      "keycode": 52,
      "unity": "Alpha4"
    },
    {
      "name": "5",
      "ahk": "5",
      "keycode": 53,
      "unity": "Alpha5"
    },
    {
      "name": "6",
      "ahk": "6",
      "keycode": 54,
      "unity": "Alpha6"
    },
    {
      "name": "7",
      "ahk": "7",
      "keycode": 55,
      "unity": "Alpha7"
    },
    {
      "name": "8",
      "ahk": "8",
      "keycode": 56,
      "unity": "Alpha8"
    },
    {
      "name": "9",
      "ahk": "9",
      "keycode": 57,
      "unity": "Alpha9"
    },
    {
      "name": "-",
      "ahk": "-",
      "keycode": 189,
      "unity": "Minus"
    },
    {
      "name": "=",
      "ahk": "=",
      "keycode": 187,
      "unity": "Equals"
    },
    {
      "name": "[",
      "ahk": "[",
      "keycode": 219,
      "unity": "LeftBracket"
    },
    {
      "name": "]",
      "ahk": "]",
      "keycode": 221,
      "unity": "RightBracket"
    },
    {
      "name": "\\",
      "ahk": "\\",
      "keycode": 220,
      "unity": "Backslash"
    },
    {
      "name": ";",
      "ahk": ";",
      "keycode": 186,
      "unity": "Semicolon"
    },
    {
      "name": "'",
      "ahk": "'",
      "keycode": 222,
      "unity": "Quote"
    },
    {
      "name": ",",
      "ahk": ",",
      "keycode": 188,
      "unity": "Comma"
    },
    {
      "name": ".",
      "ahk": ".",
      "keycode": 190,
      "unity": "Period"
    },
    {
      "name": "/",
      "ahk": "/",
      "keycode": 191,
      "unity": "Slash"
    },
    {
      "name": "`",
      "ahk": "`",
      "keycode": 192,
      "unity": "BackQuote"
    },
    {
      "name": "F1",
      "ahk": "F1",
      "keycode": 112,
      "unity": "F1"
    },
    {
      "name": "F2",
      "ahk": "F2",
      "keycode": 113,
      "unity": "F2"
    },
    {
      "name": "F3",
      "ahk": "F3",
      "keycode": 114,
      "unity": "F3"
    },
    {
      "name": "F4",
      "ahk": "F4",
      "keycode": 115,
      "unity": "F4"
    },
    {
      "name": "F5",
      "ahk": "F5",
      "keycode": 116,
      "unity": "F5"
    },
    {
      "name": "F6",
      "ahk": "F6",
      "keycode": 117,
      "unity": "F6"
    },
    {
      "name": "F7",
      "ahk": "F7",
      "keycode": 118,
      "unity": "F7"
    },
    {
      "name": "F8",
      "ahk": "F8",
      "keycode": 119,
      "unity": "F8"
    },
    {
      "name": "F9",
      "ahk": "F9",
      "keycode": 120,
      "unity": "F9"
    },
    {
      "name": "F10",
      "ahk": "F10",
      "keycode": 121,
      "unity": "F10"
    },
    {
      "name": "F11",
      "ahk": "F11",
      "keycode": 122,
      "unity": "F11"
    },
    {
      "name": "F12",
      "ahk": "F12",
      "keycode": 123,
      "unity": "F12"
    }
  ]
};