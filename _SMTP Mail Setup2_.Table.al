table 50106 "SMTP Mail Setup2"
{
    Caption = 'SMTP Mail Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "SMTP Server"; Text[250])
        {
            Caption = 'SMTP Server';
        }
        field(3; Authentication; Option)
        {
            Caption = 'Authentication';
            OptionCaption = 'Anonymous,NTLM,Basic';
            OptionMembers = Anonymous, NTLM, Basic;

            trigger OnValidate()
            begin
                IF Authentication <> Authentication::Basic THEN BEGIN
                    "User ID":='';
                    Password:='';
                END;
            end;
        }
        field(4; "User ID"; Text[250])
        {
            Caption = 'User ID';

            trigger OnValidate()
            begin
                TESTFIELD(Authentication, Authentication::Basic);
            end;
        }
        field(5; Password; Text[250])
        {
            Caption = 'Password';

            trigger OnValidate()
            begin
                TESTFIELD(Authentication, Authentication::Basic);
            end;
        }
        field(6; "SMTP Server Port"; Integer)
        {
            Caption = 'SMTP Server Port';
            InitValue = 25;
        }
        field(7; "Secure Connection"; Boolean)
        {
            Caption = 'Secure Connection';
            InitValue = false;
        }
        field(53901; "Email Sender Address"; Text[100])
        {
            Description = '//added by cyrus';
        }
        field(53902; "Path to Save Report"; Text[250])
        {
            Description = '//added by cyrus';
        }
        field(53903; "Email Sender Name"; Text[250])
        {
            Description = '//added by cyrus';
        }
        field(55475; "Payments Email Address"; Text[250])
        {
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }
    fieldgroups
    {
    }
}
