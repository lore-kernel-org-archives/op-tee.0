From: Jérôme Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: TA access to its own checksum
Date: Thu, 14 Sep 2023 16:45:06 +0200
Message-ID: 
 <CA+NB=mZCqFDNi0cSgOXG5M914vQ3UHZMboty82X9cUN6HzDGUg@mail.gmail.com>
In-Reply-To: <
 <CA+EyddaRkcvjCLKLfbuOtthp9FB9hTgeyYgS4hwFoKbcVdN4Mw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3016576867755733023=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3016576867755733023==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Sept 2023 at 12:47, Joakim Bech <joakim.bech@linaro.org> wrote:

> Hi Robert,
>
> On Thu, Sep 14, 2023 at 11:58=E2=80=AFAM Robert Delien <r.delien@payter.n=
l> wrote:
>
> > Hi,
> >
> > For legislative purposes, one of our Trusted Applications needs to show a
> > checksum to the end-user on our secure screen, to allow verification.
> > Albeit a bit unconventional use of it, we thought that the TA's own
> > checksum would be ideal for that, but we're having difficulties figuring
> > how to access that, if at all possible.
> >
> > So I have to turn to you guys here: Is there any way for a TA to access
> its
> > own checksum? And if yes, could somebody please give me some pointers on
> > how to do this?
> >
> TEE core could compute the checksum as part of loading the TA, the crux
> would
> be how to expose that to others. A possible solution would be to store it
> in memory
> as a dictionary containing the uuid and checksum. Then a pseudo TA [1]
> could hand
> out this information to clients, like other TA's or even normal world
> clients, when
> needed. I.e., pseudo TA implements and exposes a function (in pseudo code),
> looking something like this :
>    TEE_Result get_checksum_for_ta(uuid, *checksum) {
>       // Get checksum from memory
>       *checksum =3D checksum_list[uuid];
>      return ...
>    }
>
> [1]
>
> https://optee.readthedocs.io/en/latest/faq/faq.html?#q-what-is-a-pseudo-ta-=
and-how-do-i-write-one
>

A related topic is TA attestation, for which we do have some code already,
see [2] [3]. It involves signing the requested data with a per-device keyt
though, which may not be needed in the above use case.

If a simpler PTA is implemented, I suppose the checksum could be extracted
the same way as [4]. That's the same value reported in the "hash:" line in
the output of "sign_encrypt.py display":

$ ./optee_os/scripts/sign_encrypt.py display --in
out-br/build/optee_test_ext-1.0/ta/crypt/out/cb3e5ba0-adf1-11e0-998b-0002a5d5=
c51b.ta
Bootstrap TA
 struct shdr
  magic:      0x4f545348
  img_type:   1 (SHDR_BOOTSTRAP_TA)
  img_size:   357800 bytes
  algo:       0x70414930 (TEE_ALG_RSASSA_PKCS1_PSS_MGF1_SHA256)
  hash_size:  32 bytes
  sig_size:   256 bytes
  hash:
a80c7a9d85faf23087a300d979ce3fd87f745fc34cbd6732de868528f194d7eb
 struct shdr_bootstrap_ta
  uuid:       cb3e5ba0-adf1-11e0-998b-0002a5d5c51b
  ta_version: 0
 TA offset:  328 (0x148) bytes
 TA size:    357800 (0x575a8) bytes

[2]
https://github.com/OP-TEE/optee_os/blob/3.22.0/lib/libutee/include/pta_attest=
ation.h
[3] https://github.com/OP-TEE/optee_os/blob/3.22.0/core/pta/attestation.c
[4]
https://github.com/OP-TEE/optee_os/blob/3.22.0/core/pta/attestation.c#L414

--=20
Jerome

>
> > With kind regards,
> >
> >         Robert.
> >
> > --
> > DISCLAIMER
> > De informatie, verzonden in of met dit e-mailbericht, is
> > vertrouwelijk en uitsluitend voor de geadresseerde(n) bestemd. Het
> gebruik
> > van de informatie in dit bericht, de openbaarmaking, vermenigvuldiging,
> > verspreiding en|of verstrekking daarvan aan derden is niet toegestaan.
> > Gebruik van deze informatie door anderen dan geadresseerde(n) is strikt
> > verboden. Aan deze informatie kunnen geen rechten worden ontleend. U
> wordt
> > verzocht bij onjuiste adressering de afzender direct te informeren door
> > het
> > bericht te retourneren en het bericht uit uw computersysteem te
> > verwijderen.
> >
>
>
> --
> Regards,
> Joakim
>

--===============3016576867755733023==--

