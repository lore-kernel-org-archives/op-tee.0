From: Peng Fan <peng.fan@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: Linaro OP-TEE Contributions meeting Aug 2020
Date: Fri, 04 Sep 2020 01:23:11 +0000
Message-ID: <DB6PR0402MB2760C174DCB7115E756A2EA7882D0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <D3D19F82-76AC-4245-A15C-AAEBBF11CBCC@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5979959712877316755=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5979959712877316755==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Not able to receive op-tee(a)lists.trustedfirmware.org confirmation email (:!

Inline.

> Subject: Re: Linaro OP-TEE Contributions meeting Aug 2020
>=20
> Hi Peng,
>=20
> > On 3 Sep 2020, at 11:14, Peng Fan <peng.fan@nxp.com> wrote:
> >
> >> Subject: Re: Linaro OP-TEE Contributions meeting Aug 2020
> >>
> >> Hi Peng,
> >>
> >>
> >>> On 3 Sep 2020, at 10:34, Jens Wiklander via OP-TEE
> >> <op-tee@lists.trustedfirmware.org> wrote:
> >>>
> >>> Hi Peng,
> >>>
> >>> On Fri, Aug 28, 2020 at 9:10 AM Peng Fan via OP-TEE
> >>> <op-tee@lists.trustedfirmware.org> wrote:
> >>>>
> >>>> I was not able to join the meeting. Just wonder for S-EL2, is there
> >>>> any
> >> platform supporting it? How to test?
> >>
> >> Just to be sure, you mean support for running OP-TEE under a
> >> Hypervisor/SPM in S-EL2?
> >
> > Yes. Actually I not follow the design decision that supporting
> > multiple TEEs in secure world. But anyway current OP-TEE support
> > multiple XEN VMs contributed by EPAM, could this not serve normal world
> VM per future requirement?
>=20
> A couple of things assuming I am understanding your question/concern
> correctly.
>=20
> S-EL2 enables deployment of multiple TEEs. However, this is not the only use
> case. More importantly, it allows the TEE to access only the physical addre=
ss
> space it needs to. This helps in mitigating attacks on the Normal world from
> the TEE. Furthermore, it enables isolation/separation of a TEE from privile=
ged
> firmware in EL3 and S-EL2. This helps in compartmentalising the TCB if not
> reduce its size altogether. So there is the =E2=80=9Cdefense in depth/princ=
iple of least
> privilege=E2=80=9D argument too.
>=20
> This is the first step in the S-EL2 enablement story for OP-TEE i.e. run OP=
-TEE
> as a Secure VM under TF-A in EL3 and SPM in S-EL2. We have done some
> work on the FVP within Arm to enable this and will share it with Jens and
> publicly soon.
>=20
> Multiple-TEEs is a deployment choice. For example, Vendor A has TEE1 on
> which its Trusted Apps run. Vendor B has TEE2 which implements drivers to
> Secure peripherals that TAs of TEE1 need. It might not be practical or feas=
ible
> for Vendor A to port its TAs to TEE2. Hence, the two TEEs need to co-exist =
and
> communicate. S-EL2 enables isolation between TEE1 and TEE2. This helps
> reduce the level of trust that TEE2 should have on TEE1 and vice-versa.
>=20
> EPAM=E2=80=99s contribution adds awareness of virtualisation in the Normal =
world to
> OP-TEE. This enables OP-TEE to isolate communication channels, data etc
> associated with one VM from another. Without this isolation, there is a ris=
k of
> information of one VM leaking into another. Jens should have more detail on
> this topic.
>=20
> I hope this helps to clarify your concerns. Please let me know.

Yeah. Thanks for the clarification.

Currently we not have real hardware that support S-EL2, but when we have
in future, I am afraid that multiple-TEEs + S-EL2 hypervisor will introduce
more complexity in the whole software stack.

And for S-EL2, multiple TEEs, I think SMMU needs also be reconsidered
how to make sure SMMU could be used in both secure/non-secure world?

And for semiconductor company, there are two choices: multiple TEEs, TEEs
support multiple non-secure VM. Currently I am not sure what is the best
choice.

Thanks,
Peng.

>=20
> Cheers,
> Achin
>=20
>=20
> >
> > Thanks,
> > Peng.
> >
> >
> >>
> >> Cheers,
> >> Achin
> >>
> >>>
> >>> This is tested and developed using FVP as far as I know.
> >>>
> >>> Cheers,
> >>> Jens
> >>>
> >>>>
> >>>> Thanks,
> >>>> Peng.
> >>>>
> >>>> From: Joakim Bech [mailto:joakim.bech(a)linaro.org]
> >>>> Sent: 2020=E5=B9=B48=E6=9C=8827=E6=97=A5 16:21
> >>>> To: op-tee(a)lists.trustedfirmware.org
> >>>> Subject: Re: Linaro OP-TEE Contributions meeting Aug 2020
> >>>>
> >>>> Hi,
> >>>>
> >>>> Just a friendly reminder, that we have the first public "Linaro
> >>>> OP-TEE
> >> Contributions" meeting taking place later today.
> >>>> 2020-08-27(a)16.00<mailto:2020-08-27@16.00> UTC+2, 1h duration
> (for
> >> other timezones, use this URL
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feve
> >> ryti
> mezone.com%2Fs%2F12a83ab5&amp;data=3D02%7C01%7Cpeng.fan%40nxp.co
> >>
> m%7C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5
> >>
> c301635%7C0%7C0%7C637347236997122381&amp;sdata=3D3T5L%2F0kMhB
> >>
> GT%2BTu1FWxClGihm1mcKIhe52xYJeCUc68%3D&amp;reserved=3D0<https://e
> >>
> ur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feverytimezone.
> >>
> com%2Fs%2F12a83ab5&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C6
> >>
> 6d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c30163
> >>
> 5%7C0%7C0%7C637347236997122381&amp;sdata=3D3T5L%2F0kMhBGT%2BT
> >> u1FWxClGihm1mcKIhe52xYJeCUc68%3D&amp;reserved=3D0>). Connection
> details
> >> and etc can be found in the email below.
> >>>>
> >>>> This time I've also included more people on BCC who might not have
> >> subscribed to the
> >> <op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware
> >> .org
> >>>> list.
> >>>>
> >>>> Regards,
> >>>> Joakim
> >>>>
> >>>> On Wed, 19 Aug 2020 at 15:52, Joakim Bech via OP-TEE
> >> <op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware
> >> .org
> >>>> wrote:
> >>>> Hi,
> >>>>
> >>>> As part of opening up Linaro projects to the general public we plan
> >>>> to have an open monthly meeting where we discuss Linaro's
> >>>> activities
> >> around OP-TEE.
> >>>> The way that we've planned to do this is that we send out an email
> >>>> to this email list
> >>>>
> >> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli
> >> sts.tr
> >>
> ustedfirmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;data=3D02%7C01%
> >>
> 7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08d84fef6af3%7C686ea1
> >>
> d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637347236997122381&amp;s
> >>
> data=3D7fvZW6dyQ3xlsH0WqW%2BEXnzkmSvNinZwf3oYR%2BOP4U8%3D&am
> >> p;reserved=3D0<https://eur01.safelinks.protection.outlook.com/?url=3Dhttp
> >> s%3A
> >> %2F%2Flists.trustedfirmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;
> dat
> >>
> a=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08d84fef6af
> >>
> 3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63734723699712
> >>
> 2381&amp;sdata=3D7fvZW6dyQ3xlsH0WqW%2BEXnzkmSvNinZwf3oYR%2BOP4
> >> U8%3D&amp;reserved=3D0>) to gather topics to discuss. If there are no
> >> topics, then there is no meeting.
> >>>> Anyone can suggest a topic by replying to this email thread.
> >>>>
> >>>> As a first topic for this first meeting, we want to talk a bit about:
> >>>> - Linaro and the relation to TrustedFirmware.org when it comes to
> OP-TEE.
> >>>> - Where to find information.
> >>>> - What is on the agenda for the next development cycle.
> >>>>
> >>>> Calendar invitation? I could just send one out here and now, but
> >>>> due to Zoom bombing and that it'd be a logistic exercise inviting
> >>>> people, I've decided to try another approach and that is to provide
> >>>> the connection details in the meeting notes and leave it up to the
> >>>> attendees to add it to their own calendars. To try to limit
> >>>> confusion I've explicitly added the timezone and a link to
> >>>> everytimezone.com<https://eur01.safelinks.protection.outlook.com/?u
> >>>> rl
> >>>>
> >>
> =3Dhttp%3A%2F%2Feverytimezone.com%2F&amp;data=3D02%7C01%7Cpeng.fan
> >> %40nxp.
> >>>>
> >>
> com%7C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99
> >>
> c5c301635%7C0%7C0%7C637347236997122381&amp;sdata=3D1sod0wFduTTl
> >> zsTmEz%2F0J4qJSIu1e15Js423GmXGyTQ%3D&amp;reserved=3D0> so it
> should be
> >> easy to get the information in your own timezone. If this approach
> >> doesn't turn out to be good, then we will try something different in
> >> the future (I understand that canceling or shifting day/time will become=
 a
> problem).
> >>>>
> >>>> Meeting details:
> >>>> ---------------
> >>>> Date/time: Thursday Aug 27th(a)16.00<mailto:27th@16.00> (UTC+2)
> >>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fe
> >>>> ve
> >>>>
> >>
> rytimezone.com%2Fs%2F12a83ab5&amp;data=3D02%7C01%7Cpeng.fan%40nx
> >> p.com%7
> >>>>
> >>
> C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c301
> >> 635%
> >>>>
> >>
> 7C0%7C0%7C637347236997122381&amp;sdata=3D3T5L%2F0kMhBGT%2BTu1F
> >> WxClGihm1
> >>>>
> >>
> mcKIhe52xYJeCUc68%3D&amp;reserved=3D0<https://eur01.safelinks.protectio
> >>
> n.outlook.com/?url=3Dhttps%3A%2F%2Feur01.safelinks.protectio%2F&amp;dat
> >>
> a=3D02%7C01%7Cpeng.fan%40nxp.com%7Cd80f28c0d30846ceea4e08d84ffde0
> da%7C6
> >>
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637347299106238571&
> amp;sdat
> >>
> a=3DbKq%2FbdGJIOXSvusvLISHgHXtaXfFE4r5WI0OajZziHg%3D&amp;reserved=3D0
> >>>>
> >>
> n.outlook.com/?url=3Dhttps%3A%2F%2Feverytimezone.com%2Fs%2F12a83ab5
> >> &amp
> >>>> ;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08
> d8
> >> 4fef6af3
> >>>> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6373472369
> 97
> >> 122381&amp;
> >>>>
> >>
> sdata=3D3T5L%2F0kMhBGT%2BTu1FWxClGihm1mcKIhe52xYJeCUc68%3D&am
> >> p;reserved
> >>>> =3D0> Invitation/connection details: In the meeting notes Meeting
> >>>> notes:
> >>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fd
> >>>> oc
> >>>>
> >>
> s.google.com%2Fdocument%2Fd%2F15XsqgGktCrRRWiqyaz-erp_cZykwGjkBk
> >> hMD2X
> >>>>
> >>
> tUlUY&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d0df88519741b7
> >> 5aff08d
> >>>>
> >>
> 84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6373472
> >> 3699713
> >>>>
> >>
> 2377&amp;sdata=3Dp03kMVWuiSLGZvtkCpK1tHlW%2Fodgv924%2BW9YrU1ZCT
> >> Y%3D&amp
> >>>> ;reserved=3D0<https://eur01.safelinks.protection.outlook.com/?url=3Dhtt
> >>>>
> ps %3A%2F%2Fdocs.google.com%2Fdocument%2Fd%2F15XsqgGktCrRRWiqy
> >> az-erp_cZy
> >>>>
> >>
> kwGjkBkhMD2XtUlUY&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d
> >> 0df88519
> >>>>
> >>
> 741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> >> 0%7C63
> >>>>
> >>
> 7347236997132377&amp;sdata=3Dp03kMVWuiSLGZvtkCpK1tHlW%2Fodgv924
> >> %2BW9YrU
> >>>> 1ZCTY%3D&amp;reserved=3D0>
> >>>>
> >>>> Regards,
> >>>> Joakim on behalf of the Linaro OP-TEE team
> >>>> --
> >>>> OP-TEE mailing list
> >>>>
> OP-TEE(a)lists.trustedfirmware.org<mailto:OP-TEE@lists.trustedfirmware.
> >>>> org>
> >>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl
> >>>> is
> >>>>
> >>
> ts.trustedfirmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;data=3D02%7C0
> >> 1
> >>>> %7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08d84fef6af3%7C
> 68
> >> 6ea1d3bc
> >>>>
> >>
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C637347236997132377&amp;sdata
> >> =3DcgkP%2B
> >>>>
> >>
> DaYQpahvfbuiWsBoLjrTLayJkta%2F5rMX0tOteI%3D&amp;reserved=3D0<https:/
> >> /eu
> >>>> r01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.trust
> >>>> ed
> >>>>
> >>
> firmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;data=3D02%7C01%7Cpen
> >> g.fa
> >>>>
> >>
> n%40nxp.com%7C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c
> >> 6fa92c
> >>>>
> >>
> d99c5c301635%7C0%7C0%7C637347236997132377&amp;sdata=3DcgkP%2BD
> >> aYQpahvfb
> >>>> uiWsBoLjrTLayJkta%2F5rMX0tOteI%3D&amp;reserved=3D0>


--===============5979959712877316755==--

