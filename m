From: Joakim Bech <joakim.bech@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: TA access to its own checksum
Date: Thu, 14 Sep 2023 12:46:56 +0200
Message-ID: 
 <CA+EyddaRkcvjCLKLfbuOtthp9FB9hTgeyYgS4hwFoKbcVdN4Mw@mail.gmail.com>
In-Reply-To: <
 <CAEhEOQnvkuNo4HRYoS-JErLPzcRqxvu7sbNn1Hp1YAVyqKGKbA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6401563845566375560=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6401563845566375560==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On Thu, Sep 14, 2023 at 11:58=E2=80=AFAM Robert Delien <r.delien@payter.nl>=
 wrote:

> Hi,
>
> For legislative purposes, one of our Trusted Applications needs to show a
> checksum to the end-user on our secure screen, to allow verification.
> Albeit a bit unconventional use of it, we thought that the TA's own
> checksum would be ideal for that, but we're having difficulties figuring
> how to access that, if at all possible.
>
> So I have to turn to you guys here: Is there any way for a TA to access its
> own checksum? And if yes, could somebody please give me some pointers on
> how to do this?
>
TEE core could compute the checksum as part of loading the TA, the crux
would
be how to expose that to others. A possible solution would be to store it
in memory
as a dictionary containing the uuid and checksum. Then a pseudo TA [1]
could hand
out this information to clients, like other TA's or even normal world
clients, when
needed. I.e., pseudo TA implements and exposes a function (in pseudo code),
looking something like this :
   TEE_Result get_checksum_for_ta(uuid, *checksum) {
      // Get checksum from memory
      *checksum =3D checksum_list[uuid];
     return ...
   }

[1]
https://optee.readthedocs.io/en/latest/faq/faq.html?#q-what-is-a-pseudo-ta-an=
d-how-do-i-write-one


>
> With kind regards,
>
>         Robert.
>
> --
> DISCLAIMER
> De informatie, verzonden in of met dit e-mailbericht, is
> vertrouwelijk en uitsluitend voor de geadresseerde(n) bestemd. Het gebruik
> van de informatie in dit bericht, de openbaarmaking, vermenigvuldiging,
> verspreiding en|of verstrekking daarvan aan derden is niet toegestaan.
> Gebruik van deze informatie door anderen dan geadresseerde(n) is strikt
> verboden. Aan deze informatie kunnen geen rechten worden ontleend. U wordt
> verzocht bij onjuiste adressering de afzender direct te informeren door
> het
> bericht te retourneren en het bericht uit uw computersysteem te
> verwijderen.
>


--=20
Regards,
Joakim

--===============6401563845566375560==--

