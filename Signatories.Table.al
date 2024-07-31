table 50552 Signatories
{
    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Admission,Fees Structure,Exam Signatory,Exam Officer,Travel Request,Offer Letter';
            OptionMembers = " ", Admission, "Fees Structure", "Exam Signatory", "Exam Officer", "Travel Request", "Offer Letter";
        }
        field(2; "Signing Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Title/Position"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Signature; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(5; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document Type", "Signing Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var
}
