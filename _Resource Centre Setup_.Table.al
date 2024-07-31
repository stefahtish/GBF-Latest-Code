table 50478 "Resource Centre Setup"
{
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Book Requisition No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Books No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; Mails; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; MailMove; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6; "File Req No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "File Movement Numbers"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(8; "Litigation Sch. Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(9; "Conveyance Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(10; "Books Issue No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(11; "Action Numbers"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(12; Resource; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13; "Donations Ref. No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(14; "external mails No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(15; "mails send"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(16; "User Support Inc Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17; "Office No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(18; "Transport Servey No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(19; "Books Delay Charges/Day"; Decimal)
        {
        }
        field(20; "Books Due Days"; DateFormula)
        {
        }
        field(21; "Resource Admin"; Code[20])
        {
            TableRelation = "User Setup";
        }
        field(22; "Transport Provider Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(23; "Meeting Register"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(24; "Photocopy Register"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(25; "Letter Register"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(26; "Binding Register"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(27; "Waiting Charges/Hour"; Decimal)
        {
        }
        field(28; "Rooms Req Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(29; "Fuel No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(30; "Book Lost Declaration Days"; DateFormula)
        {
        }
        field(31; "Registry Email"; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
