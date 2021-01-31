From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: remove need_resched() before cond_resched()
Date: Sun, 31 Jan 2021 09:13:48 +0100
Message-ID: <42ff3eaa-d561-93ae-b5c4-28b675bdea4f@pengutronix.de>
In-Reply-To: <
 <CAHUa44GsbxO=wJ_o-AZsxNvKOhn=y=dexkrN17zCy=7+0=1ZQg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4881050442067354440=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4881050442067354440==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Jens,

On 29.01.21 14:29, Jens Wiklander wrote:
> Hi Rouven and Sumit,
> 
> On Mon, Jan 25, 2021 at 10:58 AM Jens Wiklander via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
>>
>> Hi Rouven and Sumit,
>>
>> On Mon, Jan 25, 2021 at 10:55 AM Jens Wiklander
>> <jens.wiklander@linaro.org> wrote:
>>>
>>> Testing need_resched() before cond_resched() is not needed as an
>>> equivalent test is done internally in cond_resched(). So drop the
>>> need_resched() test.
>>>
>>> Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched")
>>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>>> ---
>>>   drivers/tee/optee/call.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> Can you please test to see that this works in your setups too?
> 
> Does this work for you? I'd like to get this patch ready for v5.12.

Yes it does. I also looked at it right after Arnds mail, so for future 
reference:


cond_resched()

   _cond_resched() (ifndef CONFIG_PREEMPTION)

     should_resched(0)

       tif_need_resched() (+ preempt_count == 0 for current thread)



while:



need_resched()

   tif_need_resched()


You can add my
Reviewed-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

I also retested on the STM32-DK2 and the problem remains fixed:

Tested-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Regrads and thanks for the patch,
Rouven

--===============4881050442067354440==--

