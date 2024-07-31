tableextension 50153 VendorExt extends Vendor
{
    fields
    {
        field(50000; "KRA PIN"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                GetSetup;
                OperationSetup.TESTFIELD("PIN Min Characters");
                OperationSetup.TESTFIELD("PIN Max Characters");
                Length := STRLEN("KRA PIN");
                IF Length<>0 THEN
                  BEGIN
                    IF Length>OperationSetup."PIN Max Characters" THEN
                     ERROR(Text016,FIELDCAPTION("KRA PIN"),OperationSetup."PIN Max Characters",(Length-OperationSetup."PIN Max Characters"));
                
                    IF Length<OperationSetup."PIN Min Characters" THEN
                     ERROR(Text017,FIELDCAPTION("KRA PIN"),OperationSetup."PIN Min Characters",(OperationSetup."PIN Min Characters"-Length));
                  END;
                IF "KRA PIN"<>'' THEN
                IF NOT PensionMgt.CheckDuplicatePIN("No.","KRA PIN",MemberName) THEN
                   ERROR(Text022,"KRA PIN",MemberName);
                */
            end;
        }
        field(50001; Investment; Boolean)
        {
        }
        field(50002; "Vendor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Vendor,Share holder,Land Lord,Institutions,Custodian,registrer,Broker,Employee';
            OptionMembers = Vendor, "Share holder", "Land Lord", Institutions, Custodian, registrer, Broker, Employee;
        }
        field(50003; "Sort Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Broker Fee Rate"; Decimal)
        {
        }
        field(50005; "Investor's CSCSID"; Code[50])
        {
        }
        field(50006; "Broker Type"; Option)
        {
            OptionCaption = 'All,Purchase,Sale';
            OptionMembers = All, Purchase, Sale;
        }
        field(50007; "Bond Counter Party"; boolean)
        {
        }
        field(50008; Custodian; Boolean)
        {
        }
        field(50009; "Deposit Taker"; Boolean)
        {
        }
        field(50010; "Bond Issuer"; Boolean)
        {
        }
        field(50011; "Issuing House"; Boolean)
        {
        }
        field(50012; "Head Title"; Boolean)
        {
        }
        field(50013; registrer; Boolean)
        {
        }
        field(50014; Exchanges; Boolean)
        {
        }
        field(50015; "Clearing House"; Boolean)
        {
        }
        field(50016; "Is Trustee"; Boolean)
        {
        }
        field(50017; "Rating Agency"; Boolean)
        {
        }
        field(50018; Underwriter; Boolean)
        {
        }
        field(50029; Sector; Code[50])
        {
        }
        field(50030; Broker; Boolean)
        {
        }
        field(51002; "Vendor Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks;

            trigger OnValidate()
            begin
                if Banks.get("Vendor Bank Code")then "Vendor Bank Code Name":=banks.Name;
            end;
        }
        field(55132; "Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51003; "Vendor Bank Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code"=field("Vendor Bank Code"));

            trigger OnValidate()
            begin
                if BankBranches.get("Vendor Bank Code", "Vendor Bank Branch Code")then "Vendor Bank Branch Name":=BankBranches."Branch Name";
            end;
        }
        field(51004; "Vendor Bank Account No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51005; "NSSF Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51006; "Vendor Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51007; "Vendor Bank Code Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51008; "Vendor Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51009; "PIN Certificate Expiry"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(51010; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(51011; "Company PIN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51012; "KBA Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks;

            trigger OnValidate()
            var
                Banks: Record Banks;
            begin
                Banks.Reset();
                If Banks.Get("KBA Bank Code")then "Bank Name":=Banks.Name;
            end;
        }
        field(11; "KBA Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code"=field("KBA Bank Code"));

            trigger OnValidate()
            var
                BankBranches: Record "Bank Branches";
            begin
                BankBranches.Reset();
                BankBranches.SetRange("Branch Code", "KBA Branch Code");
                If BankBranches.FindFirst()then "Bank Branch Name":=BankBranches."Branch Name";
            end;
        }
        field(51013; "Bank account No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51014; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51015; "Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
    }
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnRename()
    begin
    end;
    var Banks: Record Banks;
    BankBranches: Record "Bank Branches";
}
