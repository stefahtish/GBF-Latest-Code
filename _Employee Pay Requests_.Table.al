table 50377 "Employee Pay Requests"
{
    fields
    {
        field(1; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.")then begin
                    "Employee Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    if EmpContract.Get(Emp."Nature of Employment")then "Employee Type":=EmpContract."Employee Type";
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Casual,Lecturer';
            OptionMembers = Casual, Lecturer;
        }
        field(5; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Time"; Time)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "No. of Units":=("End Time" - "Start Time") / 3600000;
                Validate("No. of Units");
            end;
        }
        field(7; "No. of Units"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalculateAmount;
            end;
        }
        field(8; Remarks; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Leason; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, "Pending Approval", Approved, Rejected, Paid;
        }
        field(12; "ED Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Payment Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Pay Types";

            trigger OnValidate()
            begin
            // IF PayCodes.GET("Payment Type") THEN
            //  "ED Code":=PayCodes."Earning Code";
            end;
        }
        field(15; "USER ID"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(18; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Employee Type"=FILTER(Parmanent|Partime|Locum))"Payroll PeriodX" WHERE(Closed=CONST(false))
            ELSE IF("Employee Type"=FILTER(Casual))"Payroll Period Casuals";
        }
        field(20; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Parmanent,Partime,Locum,Casual';
            OptionMembers = Parmanent, Partime, Locum, Casual;
        }
        field(21; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No", "Employee No.", Date)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        "USER ID":=UserId;
    // IF UserSetup.GET("USER ID") THEN BEGIN
    //  "Employee No.":=UserSetup."Employee No.";
    //  VALIDATE("Employee No.");
    //  IF Emp.GET("Employee No.") THEN BEGIN
    //     VALIDATE("Dimension Set ID","Dimension Set ID");
    //    "Global Dimension 1 Code":= Emp."Global Dimension 1 Code";
    //    "Global Dimension 2 Code":= Emp."Global Dimension 2 Code";
    //  END;
    //  END;
    end;
    var Emp: Record Employee;
    UserSetup: Record "User Setup";
    DimMgt: Codeunit DimensionManagement;
    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    PayrollMgt: Codeunit Payroll;
    PayCodes: Record "Employee Pay Types";
    EmpContract: Record "Employment Contract";
    local procedure CalculateAmount()
    var
        ScaleBenefit: Record "Scale Benefits";
        Emp: Record Employee;
        PayTypes: Record "Employee Pay Types";
        Rate1: Decimal;
    begin
        if PayTypes.Get("Payment Type")then begin
            case PayTypes."Calculation Type" of PayTypes."Calculation Type"::"Salary Scale": begin
                if Emp.Get("Employee No.")then begin
                    ScaleBenefit.Reset;
                    ScaleBenefit.SetRange("Salary Scale", Emp."Salary Scale");
                    ScaleBenefit.SetRange("Salary Pointer", Emp.Present);
                    ScaleBenefit.SetFilter("Payment Option", '<>%1', ScaleBenefit."Payment Option"::Amount);
                    if ScaleBenefit.FindFirst then begin
                        if ScaleBenefit."Payment Option" = ScaleBenefit."Payment Option"::"Hour Rate" then Rate1:=ScaleBenefit.Rate
                        else if ScaleBenefit."Payment Option" = ScaleBenefit."Payment Option"::Percentage then Rate1:=ScaleBenefit.Amount * ScaleBenefit.Rate / 30 / 100;
                        //MESSAGE('%1-%2-%3-%4',"Employee No.",ScaleBenefit."Salary Pointer",ScaleBenefit."Salary Scale",ScaleBenefit."Payment Option");
                        "ED Code":=ScaleBenefit."ED Code";
                        Rate:=Rate1;
                        Amount:=Rate * "No. of Units";
                    end;
                end;
            end;
            PayTypes."Calculation Type"::Formual: begin
                Amount:=PayrollMgt.GetResult(PayrollMgt.GetPureFormula("Employee No.", PayrollMgt.GetPayPeriod(), PayTypes.Formula)) * "No. of Units";
            end;
            end;
        end;
    end;
    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Employee, "Employee No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;
}
