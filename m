From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 061/141] tee: Fix fall-through warnings for Clang
Date: Tue, 20 Apr 2021 15:20:56 -0500
Message-ID: <e44a9011-f2ed-f1d2-cc1a-7dcba2f41956@embeddedor.com>
In-Reply-To: <20201123225507.GR21644@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4277319640679688325=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4277319640679688325==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 11/23/20 16:55, Gustavo A. R. Silva wrote:
> On Sun, Nov 22, 2020 at 10:26:09AM +0100, Jens Wiklander wrote:
>> On Fri, Nov 20, 2020 at 7:33 PM Gustavo A. R. Silva
>> <gustavoars@kernel.org> wrote:
>>>
>>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>>> by explicitly adding a break statement instead of letting the code fall
>>> through to the next case.
>>>
>>> Link: https://github.com/KSPP/linux/issues/115
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>  drivers/tee/tee_core.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
> 
> Thanks, Jens.
> --
> Gustavo
> 

--===============4277319640679688325==--

