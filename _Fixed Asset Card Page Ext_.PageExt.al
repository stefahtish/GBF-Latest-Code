pageextension 50132 "Fixed Asset Card Page Ext" extends "Fixed Asset Card"
{
    layout
    {
        modify("FA Subclass Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                DepBook();
                SetControlAppearance();
                CurrPage.Update();
            end;
        }
        modify("Responsible Employee")
        {
            Caption = 'Responsible user';
            Editable = true;
        }
        addafter("Responsible Employee")
        {
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Tag Number"; Rec."Tag Number")
            {
                ApplicationArea = All;
            }
            field("Vehicle Type"; Rec."Vehicle Type")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Seating/carrying capacity"; Rec."Seating/carrying capacity")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Current Odometer Reading"; Rec."Current Odometer Reading")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Registration No"; Rec."Registration No")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
        addafter("FA Subclass Code")
        {
            group(Category)
            {
                ShowCaption = false;
                Visible = SubCat;

                field("FA Subcategory"; Rec."FA Subcategory")
                {
                    ApplicationArea = All;
                }
            }
        }
        addlast("Depreciation Book")
        {
            field("FA Posting Group"; Rec."FA Posting Group")
            {
                ApplicationArea = All;
            }
            field("Fixed Asset Type"; Rec."Fixed Asset Type")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        SetControlAppearance();
    end;

    var
        SubCat: Boolean;

    local procedure DepBook()
    var
        FASubclass: Record "FA Subclass";
        DepBook: Record "FA Depreciation Book";
        AccountingPeriod: Record "Accounting Period";
        CurrenntYearStart: Date;
    begin
        AccountingPeriod.RESET;
        AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
        AccountingPeriod."Starting Date" := WORKDATE;
        if AccountingPeriod.FIND('=<') then CurrenntYearStart := AccountingPeriod."Starting Date";
        FASubclass.SetRange(Code, Rec."FA Subclass Code");
        if FASubclass.Find('-') then begin
            FASubclass.TestField("No of Depreciation Years");
            DepBook.SetRange("FA No.", Rec."No.");
            if DepBook.Find('-') then begin
                DepBook."No. of Depreciation Years" := FASubclass."No of Depreciation Years";
                DepBook."No. of Depreciation Months" := (FASubclass."No of Depreciation Years" * 12);
                DepBook."Depreciation Starting Date" := CurrenntYearStart;
                DepBook.Validate("No. of Depreciation Years");
                DepBook.Modify();
            end
            else begin
                DepBook.Init();
                DepBook."Depreciation Book Code" := '';
                DepBook."FA No." := Rec."No.";
                DepBook."No. of Depreciation Years" := FASubclass."No of Depreciation Years";
                DepBook."No. of Depreciation Months" := (FASubclass."No of Depreciation Years" * 12);
                DepBook."Depreciation Starting Date" := CurrenntYearStart;
                DepBook.Validate("No. of Depreciation Years");
                DepBook.Insert();
            end;
        end;
    end;

    procedure SetControlAppearance()
    var
        FASubclasses: Record "FA Subclass";
    begin
        FASubclasses.Reset();
        FASubclasses.SetRange(Code, Rec."FA Subclass Code");
        FASubclasses.SetRange("Has subcategories", true);
        if FASubclasses.FindFirst() then
            SubCat := true
        else
            SubCat := false;
    end;
}
