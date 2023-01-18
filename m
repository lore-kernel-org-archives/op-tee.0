From: Julius Werner <jwerner@chromium.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [TF-A] Re: Post-boot loading of OP-TEE
Date: Tue, 17 Jan 2023 17:52:47 -0800
Message-ID: 
 <CAODwPW9bYrug7Y0+WEKtWDjH8MDX9dc2st5VEvb+vNHO1XD3DA@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CAS1PR08MB7449CF6412C969A1BCBEA7A2E5C69=40AS1PR08MB?=
 =?utf-8?q?7449=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3864527989353625424=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3864527989353625424==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanna,

> My take on this is a question I ask myself. Is this a generic supportable o=
ption for the SPD or if it is more of a Chromebook specific architecture chan=
ge?

I would say the question is what you consider "Chromebook-specific".
Nothing in this feature is fundamentally tied to Chromebooks, or even
to Linux. Any platform could potentially want to choose using
something like this if they happen to have a similar OS verification
architecture and face similar reasons like us that make them disfavor
other solutions. I think an optional feature isn't necessarily not
generic just because it is only used/implemented by a single platform
(at the moment), as long as it could potentially be used/implemented
by other platforms. You wouldn't call the TRNG_SUPPORT feature in TF-A
"Juno-specific" just because it's currently only implemented by the
Juno board, either.

> I take the point there are some warning comments in the code that this chan=
ge weakens trustzone which rules out any compliance if sought but I think if =
we keep the patches as is I would like to see these warnings more prominent s=
o that non-Chromebook platforms are more fully aware and so understand the im=
plications of enabling them.

Yes, that's absolutely reasonable and the two suggestions you made
sound great. We should implement them in the next iteration of the
patch.

--===============3864527989353625424==--

