From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] ta: avb: fix object leakage at lock state write
Date: Mon, 23 Jan 2023 10:24:47 +0100
Message-ID: 
 <CAHUa44HtE7pVB0DaFe_yFRt_9mtbmau=bWZE0m7t2j=yspJJZA@mail.gmail.com>
In-Reply-To: <20230121054516.3979073-1-ivan.khoronzhuk@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4715742960025303971=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4715742960025303971==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Ivan,

On Sat, Jan 21, 2023 at 6:45 AM Ivan Khoronzhuk
<ivan.khoronzhuk@gmail.com> wrote:
>
> From: Ivan Khoronzhuk <ivan.khoronzhuk@globallogic.com>
>
> Should close object created for reading, so better use seek
> and then close the object.
>
> Fixes: b29b41950 ("ta: add AVB TA")
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@globallogic.com>
> ---
>  ta/avb/entry.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/ta/avb/entry.c b/ta/avb/entry.c
> index 4e57003e..a6e01035 100644
> --- a/ta/avb/entry.c
> +++ b/ta/avb/entry.c
> @@ -239,7 +239,11 @@ static TEE_Result write_lock_state(uint32_t pt,
>         if (count == sizeof(lock_state) && lock_state == wlock_state)
>                 goto out;
>
> -       res = create_rb_state(wlock_state, &h);
> +       res = TEE_SeekObjectData(h, 0, TEE_DATA_SEEK_SET);
> +       if (res)
> +               goto out;
> +
> +       res = TEE_WriteObjectData(h, &wlock_state, sizeof(wlock_state));
>  out:
>         TEE_CloseObject(h);
>         return res;
> --
> 2.34.1
>

The patch looks good. Would you mind opening a pull request at
https://github.com/OP-TEE/optee_os?

Cheers,
Jens

--===============4715742960025303971==--

