window.onload = function() {
    var query_string = window.location.search;

    var match_result = query_string.match(/(\d{4})(?:-(.+))?/);

    if (match_result) {
        if (match_result[1] && match_result[2]) {
            // 各個別記事
            url = "articles/" + match_result[1] + "/" + match_result[1] + "-" + match_result[2] + ".html";
        } else {
            // 各号の表紙
            url = "articles/" + match_result[1] + "/" + match_result[1] + "-index.html";
        }
        document.getElementById("redirect_notice").innerHTML = "http://magazine.rubyist.net/" + query_string + "はhttp://magazine.rubyist.net/" + url + "に移行しました。<br />ブックマーク等の変更をお願いします。";
        document.getElementById("redirect_notice").style.color = "white";
        document.getElementById("redirect_notice").style.backgroundColor = "red";
        setTimeout("redirect_newpage('" + url + "')", 500);
    }
}

function redirect_newpage(url) {
    location.href = url;
}
