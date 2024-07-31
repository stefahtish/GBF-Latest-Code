page 51025 "Monthly Return Product"
{
    Caption = 'Monthly Return Product';
    PageType = ListPart;
    SourceTable = "Monthly Returns  Product";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ApplicationNo; Rec.ApplicationNo)
                {
                    Visible = false;
                }
                field(Product; Rec.Product)
                {
                    caption = 'Nature of Produce';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field(SubProduct; Rec.SubProduct)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field("Others"; Rec."Others Description")
                {
                    Visible = IsOther;
                    Caption = 'Others (Specify)';
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    var
        HasSubheading: Boolean;
        IsOther: Boolean;

    procedure SetControlAppearance()
    var
        Produce: Record "Dairy Produce Setup";
    begin
        Produce.Reset();
        Produce.SetRange("Dairy Produce", Rec.Product);
        Produce.SetRange(Others, true);
        if Produce.FindFirst() then
            IsOther := true
        else begin
            Produce.Reset();
            Produce.SetRange("Dairy Produce", Rec.SubProduct);
            Produce.SetRange(Others, true);
            if Produce.FindFirst() then IsOther := true
        end;
    end;
}
