tableextension 50158 CompanyInfoExt extends "Company Information"
{
    fields
    {
        field(50000; "Scheme PIN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Bank Account Name"; Text[50])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
        }
        field(50002; "Bank Name 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Bank Branch No.2"; Text[20])
        {
            Caption = 'Bank Branch No.';
            DataClassification = ToBeClassified;
        }
        field(50004; "Bank Account No.2"; Text[30])
        {
            Caption = 'Bank Account No. (KES)';
            DataClassification = ToBeClassified;
        }
        field(50005; "SWIFT Code2"; Code[20])
        {
            Caption = 'SWIFT Code';
            DataClassification = ToBeClassified;
        }
        field(50006; "Bank Account Name2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "MPESA Paybill"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Bank Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Bank Branch Name2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Document Path"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "E-Mail Signature"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(50012; "Online Document Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Sharepoint URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Sharepoint Username"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Sharepoint Password"; Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Encryption: Codeunit "Cryptography Management";
            begin
                if Encryption.IsEncryptionEnabled()then begin
                //Encryption.Encrypt("Sharepoint Password");
                end end;
        }
        field(50016; "Sharepoint Domain"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Sharepoint Library"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Sharepoint Folder"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Save to Sharepoint"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Bank Account No.3"; Text[30])
        {
            Caption = 'Bank Account No. (USD)';
            DataClassification = ToBeClassified;
        }
    }
}
