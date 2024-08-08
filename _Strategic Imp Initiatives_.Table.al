table 50313 "Strategic Imp Initiatives"
{
    Caption = 'Strategic Implementation Initiatives';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SNo."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Initiatives; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; ObjectiveCode; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Strategic Objectives"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Employee No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Appraisal Period"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Timelines; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Target No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Self Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                TotalSelfRating: Decimal;

            begin
                TotalSelfRating := CalculateTotalSelfRating("Employee No.", "Appraisal Period", "Target No.", ObjectiveCode);
                if TotalSelfRating + "Self Rating" > 16 then
                    Error('Total Self Rating cannot exceed 16. Current total: %1', TotalSelfRating);
                ConvertedRating := ConvertTotalSelfRatingToRating("Self Rating");
                // Message('Converted Rating: %1', ConvertedRating)
                rec.Score := ConvertedRating;
            end;

        }
        field(11; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Performance Appraisal Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Moderated Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Mark Out of Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }



    }
    keys
    {
        key(PK; "SNo.", Initiatives, ObjectiveCode, "Target No.", "Employee No.", "Appraisal Period")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "SNo.", Initiatives)
        {
        }
    }
    var
        StrategicImpInitiativesRec: Record "Strategic Imp Initiatives";
        ConvertedRating: Decimal;
        RatingArray: array[17] of Decimal;

    procedure CalculateTotalSelfRating(EmployeeNo: Code[50]; AppraisalPeriod: Code[20]; TargetCode: code[50]; Object: Integer): Decimal
    var
        TotalSelfRating: Decimal;
    begin
        StrategicImpInitiativesRec.SetRange("Employee No.", EmployeeNo);
        StrategicImpInitiativesRec.SetRange("Appraisal Period", AppraisalPeriod);
        StrategicImpInitiativesRec.SetRange("Target No.", TargetCode);
        StrategicImpInitiativesRec.SetRange(ObjectiveCode, Object);
        if StrategicImpInitiativesRec.FindSet then
            repeat
                TotalSelfRating += StrategicImpInitiativesRec."Self Rating";
            until StrategicImpInitiativesRec.Next = 0;
        exit(TotalSelfRating);
    end;

    procedure ConvertTotalSelfRatingToRating(TotalSelfRating: Decimal): Decimal
    begin
        // case TotalSelfRating of
        //     16:
        //         exit(5);
        //     15:
        //         exit(4.69);
        //     14:
        //         exit(4.38);
        //     13:
        //         exit(4.06);
        //     12:
        //         exit(3.75);
        //     11:
        //         exit(3.44);
        //     10:
        //         exit(3.13);
        //     9:
        //         exit(2.81);
        //     8:
        //         exit(2.5);
        //     7:
        //         exit(2.19);
        //     6:
        //         exit(1.88);
        //     5:
        //         exit(1.56);
        //     4:
        //         exit(1.25);
        //     3:
        //         exit(0.94);
        //     2:
        //         exit(0.63);
        //     1:
        //         exit(0.31);
        //     else
        //         exit(0);
        // end;
        if TotalSelfRating >= 16 then
            exit(5)
        else if TotalSelfRating >= 15 then
            exit(4.69 + (TotalSelfRating - 15) * (5 - 4.69) / (16 - 15))
        else if TotalSelfRating >= 14 then
            exit(4.38 + (TotalSelfRating - 14) * (4.69 - 4.38) / (15 - 14))
        else if TotalSelfRating >= 13 then
            exit(4.06 + (TotalSelfRating - 13) * (4.38 - 4.06) / (14 - 13))
        else if TotalSelfRating >= 12 then
            exit(3.75 + (TotalSelfRating - 12) * (4.06 - 3.75) / (13 - 12))
        else if TotalSelfRating >= 11 then
            exit(3.44 + (TotalSelfRating - 11) * (3.75 - 3.44) / (12 - 11))
        else if TotalSelfRating >= 10 then
            exit(3.13 + (TotalSelfRating - 10) * (3.44 - 3.13) / (11 - 10))
        else if TotalSelfRating >= 9 then
            exit(2.81 + (TotalSelfRating - 9) * (3.13 - 2.81) / (10 - 9))
        else if TotalSelfRating >= 8 then
            exit(2.5 + (TotalSelfRating - 8) * (2.81 - 2.5) / (9 - 8))
        else if TotalSelfRating >= 7 then
            exit(2.19 + (TotalSelfRating - 7) * (2.5 - 2.19) / (8 - 7))
        else if TotalSelfRating >= 6 then
            exit(1.88 + (TotalSelfRating - 6) * (2.19 - 1.88) / (7 - 6))
        else if TotalSelfRating >= 5 then
            exit(1.56 + (TotalSelfRating - 5) * (1.88 - 1.56) / (6 - 5))
        else if TotalSelfRating >= 4 then
            exit(1.25 + (TotalSelfRating - 4) * (1.56 - 1.25) / (5 - 4))
        else if TotalSelfRating >= 3 then
            exit(0.94 + (TotalSelfRating - 3) * (1.25 - 0.94) / (4 - 3))
        else if TotalSelfRating >= 2 then
            exit(0.63 + (TotalSelfRating - 2) * (0.94 - 0.63) / (3 - 2))
        else if TotalSelfRating >= 1 then
            exit(0.31 + (TotalSelfRating - 1) * (0.63 - 0.31) / (2 - 1))
        else
            exit(0);
    end;


}
