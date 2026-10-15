function hfun_canonical_url()
    return replace(locvar("fd_full_url"), r"/index\.html$" => "/")
end

const MONTH = ["January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December"]

function getdate(fpath)
    fn = splitext(basename(fpath))[1]
    m = match(r"^(\d{4})-(\d{2})-(\d{2})", fn)
    isnothing(m) && return nothing
    y, mo, d = parse.(Int, m.captures)
    return "$(MONTH[mo]) $d, $y"
end

function hfun_blogposts()
    posts = filter(endswith(".md"), readdir("post"; join=true))
    sort!(posts; rev=true)
    io = IOBuffer()
    println(io, "<ul class=\"post-list\">")
    for p in posts
        fn = splitext(basename(p))[1]
        fn == "index" && continue
        date = getdate(p)
        date_str = isnothing(date) ? "" : """<span class="post-date">$date</span>"""
        title_match = match(r"^@def title\s*=\s*\"(.+?)\"", read(p, String))
        title = isnothing(title_match) ? fn : title_match[1]
        println(io, "<li>$(date_str)<a href=\"/post/$fn/\">$title</a></li>")
    end
    println(io, "</ul>")
    return String(take!(io))
end

function hfun_post_date()
    date = getdate(locvar("fd_rpath"))
    isnothing(date) && return ""
    return "<p class=\"post-date\">$date</p>"
end
