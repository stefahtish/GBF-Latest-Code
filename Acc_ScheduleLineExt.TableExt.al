tableextension 50161 Acc_ScheduleLineExt extends "Acc. Schedule Line"
{
    fields
    {
        field(50000; "Include Closing Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Placement; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Row,Header';
            OptionMembers = Row, Header;
        }
        field(50002; "Purchases Totaling"; Text[250])
        {
            Caption = 'Purchases Totaling';
            DataClassification = ToBeClassified;
            TableRelation = IF("Totaling Type"=CONST("Posting Accounts"))"G/L Account"
            ELSE IF("Totaling Type"=CONST("Total Accounts"))"G/L Account"
            ELSE IF("Totaling Type"=CONST("Cash Flow Entry Accounts"))"Cash Flow Account"
            ELSE IF("Totaling Type"=CONST("Cash Flow Total Accounts"))"Cash Flow Account"
            ELSE IF("Totaling Type"=CONST("Cost Type"))"Cost Type"
            ELSE IF("Totaling Type"=CONST("Cost Type Total"))"Cost Type";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
            //LookupTotaling;
            end;
            trigger OnValidate()
            begin
                CASE "Totaling Type" OF "Totaling Type"::"Posting Accounts", "Totaling Type"::"Total Accounts": BEGIN
                    GLAcc.SETFILTER("No.", Totaling);
                    GLAcc.CALCFIELDS(Balance);
                END;
                "Totaling Type"::Formula, "Totaling Type"::"Set Base For Percent": BEGIN
                    Totaling:=UPPERCASE(Totaling);
                    CheckFormula(Totaling);
                END;
                "Totaling Type"::"Cost Type", "Totaling Type"::"Cost Type Total": BEGIN
                    CostType.SETFILTER("No.", Totaling);
                    CostType.CALCFIELDS(Balance);
                END;
                "Totaling Type"::"Cash Flow Entry Accounts", "Totaling Type"::"Cash Flow Total Accounts": BEGIN
                    CFAccount.SETFILTER("No.", Totaling);
                    CFAccount.CALCFIELDS(Amount);
                END;
                END;
            end;
        }
        field(50003; "Disposal Totaling"; Text[250])
        {
            Caption = 'Disposal Totaling';
            DataClassification = ToBeClassified;
            TableRelation = IF("Totaling Type"=CONST("Posting Accounts"))"G/L Account"
            ELSE IF("Totaling Type"=CONST("Total Accounts"))"G/L Account"
            ELSE IF("Totaling Type"=CONST("Cash Flow Entry Accounts"))"Cash Flow Account"
            ELSE IF("Totaling Type"=CONST("Cash Flow Total Accounts"))"Cash Flow Account"
            ELSE IF("Totaling Type"=CONST("Cost Type"))"Cost Type"
            ELSE IF("Totaling Type"=CONST("Cost Type Total"))"Cost Type";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
            //LookupTotaling;
            end;
            trigger OnValidate()
            begin
                CASE "Totaling Type" OF "Totaling Type"::"Posting Accounts", "Totaling Type"::"Total Accounts": BEGIN
                    GLAcc.SETFILTER("No.", Totaling);
                    GLAcc.CALCFIELDS(Balance);
                END;
                "Totaling Type"::Formula, "Totaling Type"::"Set Base For Percent": BEGIN
                    Totaling:=UPPERCASE(Totaling);
                    CheckFormula(Totaling);
                END;
                "Totaling Type"::"Cost Type", "Totaling Type"::"Cost Type Total": BEGIN
                    CostType.SETFILTER("No.", Totaling);
                    CostType.CALCFIELDS(Balance);
                END;
                "Totaling Type"::"Cash Flow Entry Accounts", "Totaling Type"::"Cash Flow Total Accounts": BEGIN
                    CFAccount.SETFILTER("No.", Totaling);
                    CFAccount.CALCFIELDS(Amount);
                END;
                END;
            end;
        }
        field(50004; "Change In Fair Value Totaling"; Text[250])
        {
            Caption = 'Change In Fair Value Totaling';
            DataClassification = ToBeClassified;
            TableRelation = IF("Totaling Type"=CONST("Posting Accounts"))"G/L Account"
            ELSE IF("Totaling Type"=CONST("Total Accounts"))"G/L Account"
            ELSE IF("Totaling Type"=CONST("Cash Flow Entry Accounts"))"Cash Flow Account"
            ELSE IF("Totaling Type"=CONST("Cash Flow Total Accounts"))"Cash Flow Account"
            ELSE IF("Totaling Type"=CONST("Cost Type"))"Cost Type"
            ELSE IF("Totaling Type"=CONST("Cost Type Total"))"Cost Type";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
            //LookupTotaling;
            end;
            trigger OnValidate()
            begin
                CASE "Totaling Type" OF "Totaling Type"::"Posting Accounts", "Totaling Type"::"Total Accounts": BEGIN
                    GLAcc.SETFILTER("No.", Totaling);
                    GLAcc.CALCFIELDS(Balance);
                END;
                "Totaling Type"::Formula, "Totaling Type"::"Set Base For Percent": BEGIN
                    Totaling:=UPPERCASE(Totaling);
                    CheckFormula(Totaling);
                END;
                "Totaling Type"::"Cost Type", "Totaling Type"::"Cost Type Total": BEGIN
                    CostType.SETFILTER("No.", Totaling);
                    CostType.CALCFIELDS(Balance);
                END;
                "Totaling Type"::"Cash Flow Entry Accounts", "Totaling Type"::"Cash Flow Total Accounts": BEGIN
                    CFAccount.SETFILTER("No.", Totaling);
                    CFAccount.CALCFIELDS(Amount);
                END;
                END;
            end;
        }
        field(50005; "Investment Note"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Notes; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Show Notes"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Notes,Page';
            OptionMembers = " ", Notes, "Page";
        }
        field(50008; "Membership Subtype"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'As is,Additions,Leavers,Death,Adjustments,Reinstatements';
            OptionMembers = "As is", Additions, Leavers, Death, Adjustments, Reinstatements;
        }
    }
    var GLAcc: Record "G/L Account";
    CFAccount: Record "Cash Flow Account";
    CostType: Record "Cost Type";
}
