From: Linus Walleij <linus.walleij@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 05 Mar 2024 13:29:38 +0100
Message-ID: 
 <CACRpkdbhhZ9+Jy_tvWy1RSnyZMjqUhh0ARpS+WRtgWTH3AYCPw@mail.gmail.com>
In-Reply-To: <20240227153132.2611499-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0295955367582950439=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0295955367582950439==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Jens,

I realized there is one thing I wonder about:

On Tue, Feb 27, 2024 at 4:31 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:

> +struct rpmb_frame {
> +       u8     stuff[196];
> +       u8     key_mac[32];
> +       u8     data[256];
> +       u8     nonce[16];
> +       __be32 write_counter;
> +       __be16 addr;
> +       __be16 block_count;
> +       __be16 result;
> +       __be16 req_resp;
> +} __packed;

I didn't quite get why these things are encoded big-endian?

As on the producer side (the eMMC backend) it seems we are anyway
calling cpu_to_be* to convert them into this format.

If this is a requirement on the consumer side (such as TEE) I think
the consumer should swap the bytes rather than the producer,
but I guess that kind of assumes that we foresee there will be other
consumers in the first place.

Yours,
Linus Walleij

--===============0295955367582950439==--

