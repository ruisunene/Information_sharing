// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


/*チャット画面・遷移後ページの一番下が表示されるようになる*/
document.addEventListener("turbolinks:load", () => {
    function scrollToEnd() {
        const messageindex = document.getElementById('scroll-inner');
        messageindex.scrollTop = messageindex.scrollHeight;
    }
    scrollToEnd()
})

/*document.addEventListener 画面を読み込む前にJavaScriptが走るのを防ぐ為、先にイベント(htnml)を読み込んでいる*/
/*turbolinks:load 初回読み込み、リロード、ページ切り替えで作用する*/
/*function scrollToEnd 関数を定義*/
/*const messageindex 定数の宣言*/
/*document.getElementById HTMLタグで指定したIDのドキュメントを取得するメソッド */
/*document.getElementById('scroll-inner')
htmlのdviタグで指定したID(scroll-inner)取得・divタグ内の要素を取得*/
/*messageindex.scrollTop = messageindex.scrollHeight
message-indexのスクロールの一番上と高さを指定*/
/*scrollToEnd 定義した関数を実行する*/
