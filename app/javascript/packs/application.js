require("@rails/ujs").start();
// vue画面でブラウザバックで白画面になるのを防ぐ
// require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

import "stylesheets/application.scss";
import "../css/tailwind.scss";
import "../css/main.scss";
