page 50975 "Sample Conditions Lines"
{
    Caption = 'Sample Condition';
    PageType = ListPart;
    SourceTable = "Sample Conditions Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Additional Information"; Rec."Additional Information")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Batch Number"; Rec."Batch Number")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Option; Rec.Option)
                {
                    ApplicationArea = All;
                    Enabled = false;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Enabled = UnitofMeasue;
                }
                field("Expiry date needed"; Rec."Expiry date needed")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Batch Number needed"; Rec."Batch Number needed")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Explanation Needed"; Rec."Explanation Needed")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        [InDataSet]
        ExpiryDate: Boolean;
        [InDataSet]
        BatchNo: Boolean;
        [InDataSet]
        Explanation: Boolean;
        UnitofMeasue: Boolean;
        SampleRec: Record "Sample Reception Header";
        LabSetup: Record "Laboratory Setup Type";

    procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        Rec.CalcFields("Explanation Needed", "Expiry date needed", "Batch Number needed");
        if Rec."Expiry date needed" = true then
            ExpiryDate := true
        else
            ExpiryDate := false;
        if Rec."Batch Number needed" = true then
            BatchNo := true
        else
            BatchNo := false;
        if Rec."Explanation Needed" = true then
            Explanation := true
        else
            Explanation := false;
        LabSetup.Reset();
        LabSetup.SetRange(Name, Rec.Code);
        if LabSetup.FindFirst() then begin
            if LabSetup."Has Unit of Measure" = true then
                UnitofMeasue := true
            else
                UnitofMeasue := false;
        end;
    end;
}
