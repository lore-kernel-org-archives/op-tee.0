From: Jérôme Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [EXTERNAL] Re: Current design of tee-supplicant can't support
 ftpm requests during kernel space bootup
Date: Mon, 25 Jul 2022 16:14:06 +0200
Message-ID: 
 <CAA-cTWZjFEeqDWoowYMaazfQNGJhBtu=CUWbMbHfCjW0+-5bUQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYN0tLZp8=PNV46NcjGgG=stNwwxtzxz3wFP_4m8OUODNw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2223239094555530596=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2223239094555530596==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Jul 21, 2022 at 11:46 AM Sumit Garg <sumit.garg@linaro.org> wrote:

> On Thu, 21 Jul 2022 at 14:41, Judy Wang <wangjudy@microsoft.com> wrote:
>
> > I can see the whole design is rooted with the idea of having
> tee-supplicant as the servant, don't think it's worth to flip the whole
> design just to fill the gap before user space is up. We haven't really come
> up with a design so will keep you posted.
>
> You don't need to flip the tee-supplicant design but rather just
> handle RPMB requests in the kernel itself if it's supported by MMC
> driver (you need a similar hook in the kernel as we have in u-boot
> [1]). All other OP-TEE RPC requests unhandled by the kernel can be
> forwarded to the user-mode tee-supplicant.
>

Correct but please keep in mind that we have RPMB emulation code inside
tee-supplicant, which is quite useful for testing. Therefore any "fast
path" to the MMC driver inside the OP-TEE driver should probably be opt-out.

-- 
Jerome

--===============2223239094555530596==--

