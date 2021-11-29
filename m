From: Dan Carpenter <dan.carpenter@oracle.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: amdtee: fix an IS_ERR() vs NULL bug
Date: Mon, 29 Nov 2021 11:54:04 +0300
Message-ID: <20211129085404.GQ18178@kadam>
In-Reply-To: <tencent_F4542B974E00912E031D1999D6D98F8C9006@qq.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9129248736341867419=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9129248736341867419==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, Nov 29, 2021 at 04:31:51PM +0800, 994605959 wrote:
>    maybe try this?
>    -  if (IS_ERR(*ta)) {
>    -    pr_err("%s: get_free_pages failed 0x%llx\n", __func__,
>    -           (u64)*ta);
>    +  if (IS_ERR(ta)) {
>    +    pr_err("%s: get_free_pages failed %p\n", __func__, ta);


No, what you are suggesting is totally wrong.  You are checking the
wrong variable for the wrong thing.

regards,
dan carpenter


--===============9129248736341867419==--

