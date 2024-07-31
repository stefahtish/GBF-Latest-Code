tableextension 50123 SalesLineExt extends "Sales Line"
{
    fields
    {
        field(50000; "Lease No."; Code[20])
        {
        }
        field(50001; "Property No."; Code[20])
        {
        }
        field(50002; "Property Floor"; Code[40])
        {
        }
        field(50003; "Property Unit"; Code[40])
        {
        }
        field(50004; "Previous Readings"; Decimal)
        {
        }
        field(50005; "Current Readings"; Decimal)
        {
        }
        field(50006; "Consumption Amount"; Decimal)
        {
        }
        field(50007; "Area Square ft"; Decimal)
        {
        }
        field(50008; "Currently monthly Rent"; Decimal)
        {
        }
        field(50009; "Current Service Charge"; Decimal)
        {
        }
        field(50010; Total; Decimal)
        {
        }
        field(50011; "Rent/S.Charge Rate"; Decimal)
        {
        }
        field(50012; "Charge No."; Code[40])
        {
        }
        field(50013; "Service Charge"; Boolean)
        {
        }
        field(50014; Rent; Boolean)
        {
        }
        field(50015; "Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Levy, "Levy Penalty";
            OptionCaption = ' ,Levy,Levy Penalty';
            Enabled = false;
            ObsoleteState = Removed;

            trigger OnValidate()
            var
                LevySetup: record "Cess and Levy setup";
            begin
                LevySetup.Get();
            // if "Line Type" = "Line Type"::Levy then begin
            //     Type := Type::"G/L Account";
            //     "No." := LevySetup."Levy Receivables";
            // end;
            // if "Line Type" = "Line Type"::"Levy Penalty" then begin
            //     Type := Type::"G/L Account";
            //     "No." := LevySetup."Levy Penalty Receivables";
            // end;
            end;
        }
        field(50016; "Project Code"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50017; "Phase"; text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = PMWorkPlan.Phase;
        }
    }
    trigger OnBeforeInsert()
    var
        SalesHeader: Record "Sales Header";
        nn: Page "Customer Card";
    begin
        if Rec."Document Type" = "Document Type"::Invoice then begin
            SalesHeader.Reset();
            SalesHeader.SetRange("No.", "Document No.");
            if SalesHeader.FindFirst()then Rec."Project Code":=SalesHeader."Project Code";
        end;
    end;
    var
}
