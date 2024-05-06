document.addEventListener('DOMContentLoaded', function () {
    let userPrefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    if (window.localStorage.getItem("mode"))
        userPrefersDark = window.localStorage.getItem("mode");
    setTheme(userPrefersDark)
    setHeartAsSlider(window.localStorage.getItem("heart"));

    document.getElementById("themeButton").addEventListener("click", e => {
        window.localStorage.setItem("mode", setTheme(document.body.classList.contains("dark-mode")));
    });

    document.getElementById("heartButton").addEventListener("click", e => {
        window.localStorage.setItem("heart", setHeartAsSlider(document.querySelector(".heart").classList.contains("heartNoHeart")));
    });
    //slider support for hearts
    for (let r of document.getElementsByClassName('slider')) {
        let s = r.parentNode.children[1];
        let Swidth = Number(window.getComputedStyle(s).width.slice(-100, -2));
        r.addEventListener('input', e => {
            let s = r.parentNode.children[1];
            let toolWidth = Number(window.getComputedStyle(r).width.slice(-100, -2));
            const ratio = (r.value - r.min) / (r.max - r.min);
            let offset = (-ratio * 11.5) + 1;
            if (Swidth > 10)
                offset = (-ratio * 11.5) - 2.25;
            s.style.left = `calc(${offset}px + ${toolWidth} * ${ratio}px)`;
        });
        r.dispatchEvent(new CustomEvent("input"));
    }
});

function setTheme(theme = "light") {
    if (theme == "light" || theme == 1) {
        document.body.classList.remove('dark-mode');
        document.body.classList.add('light-mode');
        theme = "light";
    } else {
        document.body.classList.remove('light-mode');
        document.body.classList.add('dark-mode');
        theme = "dark";
    }
    changeColorOfHeart();
    return theme;
}

function setHeartAsSlider(slider = "heart") {
    for (let r of document.getElementsByClassName('heart')) {
        if (slider == "heart" || slider == 1) {
            r.classList.remove("heartNoHeart");
            slider = "heart";
        } else {
            r.classList.add("heartNoHeart");
            r.style.backgroundImage = null;
            slider = "noheart";
        }
    }
    changeColorOfHeart();
    return slider;
}

function changeColorOfHeart() {
    let svg = 'url("data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2024%2024%22%20width%3D%22100%22%20height%3D%22100%22%3E%3Cpath%20fill%3D%22%23000000%22%20stroke%3D%22%23fff%22%20stroke-width%3D%222%22%20d%3D%22m12%2021.35-1.45-1.32C5.4%2015.36%202%2012.28%202%208.5%202%205.42%204.42%203%207.5%203c1.74%200%203.41.81%204.5%202.09C13.09%203.81%2014.76%203%2016.5%203%2019.58%203%2022%205.42%2022%208.5c0%203.78-3.4%206.86-8.55%2011.54z%22%2F%3E%3C%2Fsvg%3E")';
    for (let r of document.getElementsByClassName('heart')) {
        if (window.getComputedStyle(r).backgroundImage.includes("none") || r.classList.contains("heartNoHeart"))
            continue;
        let x = getComputedStyle(document.body).getPropertyValue('--slider-color').substring(1);
        r.style.backgroundImage = svg.replace('000000', x);
    }
}

