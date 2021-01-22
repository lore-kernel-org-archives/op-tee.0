From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE driver fix for v5.11
Date: Fri, 22 Jan 2021 15:25:37 +0100
Message-ID: 
 <CAK8P3a12gaDHLTrayEuWp5gkDK8EyMOZDH+Zd3fgMHi7=KOaVQ@mail.gmail.com>
In-Reply-To: <20210122074234.GA1074747@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4777833309100456733=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4777833309100456733==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2021 at 8:42 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> for you to fetch changes up to dcb3b06d9c34f33a249f65c08805461fb0c4325b:
>
>   tee: optee: replace might_sleep with cond_resched (2021-01-21 10:36:48 +0=
100)
>
> ----------------------------------------------------------------
> Fix rcu_sched trace from OP-TEE invoke
>
> Replaces might_sleep() with a conditional call to cond_resched()
> in order to avoid the rcu_sched trace in some corner cases.

Hi Rouven,

The bugfix looks correct in the sense that it fixes the issue, but
it took me a while to understand what you actually try to do here
because of the unusual way it's written as

              if (need_resched())
                          cond_resched();

which /looks/ like you are doing something fishy here. In the
end I concluded that this was probably just a misunderstanding
of what cond_resched() does.

Can you replace it with a normal

       cond_resched()

without the second need_resched() check and make sure this
still works? cond_resched() by definition performs the check
to ensure that rescheduling is needed, so unless you want to
explicitly hide the might_sleep() in it from being seen, it's
better to call that.

        Arnd

--===============4777833309100456733==--

