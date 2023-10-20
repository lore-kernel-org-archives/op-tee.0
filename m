From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Secure interrupt while sending direct response
Date: Fri, 20 Oct 2023 14:46:39 +0200
Message-ID: 
 <CAHUa44F3-Y1XdkECVg2Mx=mLjze0uQZj=9ZTCrX5ce+qO9TO8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5086162558443885332=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5086162558443885332==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm testing FF-A notifications with OP-TEE and Hafnium. I'm using
interrupts from the secure uart as a trigger to set a notification for
the normal world. Sometimes when testing I run into:
VERBOSE: Secure virtual interrupt not yet serviced by SP 8001.
FFA_MSG_SEND_DIRECT_RESP interrupted

Hafnium then returns an FFA_ERROR (code -5) as a response to the
FFA_MSG_SEND_DIRECT_RESP OP-TEE was just exiting with. After some
digging in the code I find a comment at the top of
plat_ffa_is_direct_response_interrupted()
https://git.trustedfirmware.org/hafnium/hafnium.git/tree/src/arch/aarch64/pla=
t/ffa/spmc.c#n2539

/*
* A secure interrupt might trigger while the target SP is currently
* running to send a direct response. SPMC would then inject virtual
* interrupt to vCPU of target SP and resume it.
* However, it is possible that the S-EL1 SP could have its interrupts
* masked and hence might not handle the virtual interrupt before
* sending direct response message. In such a scenario, SPMC must
* return an error with code FFA_INTERRUPTED to inform the S-EL1 SP of
* a pending interrupt and allow it to be handled before sending the
* direct response.
*/

The specification doesn't mention this as a valid error code for
FFA_MSG_SEND_DIRECT_RESP. Is this something we can expect to be added
to the specification or at least something OP-TEE has to be prepared
to handle regardless?

As far as I can tell there's no way of guaranteeing that Hafnium will
not return this error for FFA_MSG_SEND_DIRECT_RESP. Even if we were
able to execute the smc instruction with secure interrupts unmasked,
what if the interrupt is raised just after the smc instruction has
been trapped in Hafnium?
It is a bit inconvenient as it means saving the registers passed to
the smc instruction to be able to restart the smc instruction with the
same arguments. It seems we may need to redesign the exit procedure.
It would be nice with an example of how an S-EL1 SP is supposed to
exit with FFA_MSG_SEND_DIRECT_RESP.

Thoughts?

Thanks,
Jens

--===============5086162558443885332==--

