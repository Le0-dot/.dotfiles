require("bookmarks"):setup({
    last_directory = { enable = true, persist = true },
    persist = "all",
    desc_format = "full",
    file_pick_mode = "parent",
    notify = {
        enable = true,
        timeout = 1,
        message = {
            new = "New bookmark '<key>' -> '<folder>'",
            delete = "Deleted bookmark in '<key>'",
            delete_all = "Deleted all bookmarks",
        },
    },
})