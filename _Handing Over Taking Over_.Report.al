report 50181 "Handing Over Taking Over"
{
    DefaultLayout = word;
    WordLayout = 'HandingOver.docx';
    RDLCLayout = './RHandingOver.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("FA Disposal"; "FA Disposal")
        {
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompPic; CompanyInfo.Picture)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(Companycity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(Department; Department)
            {
            }
            dataitem("FA Disposal Line"; "FA Disposal Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(FA_No_; "FA No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Acquisition_Date; "Acquisition Date")
                {
                }
                column(Estimated_Current_Value; "Estimated Current Value")
                {
                }
                column(Original_Purchase_Value; "Original Purchase Value")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Condition; Condition)
                {
                }
                column(Fixed_Asset_Register_No_; "Fixed Asset Register No.")
                {
                }
                dataitem(Bids; "Procurement Request Lines")
                {
                    DataItemLink = "FA Disposal Doc No." = field("Document No."), No = field("FA No."), "Line No" = field("Line No.");
                    DataItemTableView = where("Bid Submitted" = const(true));

                    column(Staff_No_; "Staff No.")
                    {
                    }
                    column(StaffName; "Staff Name")
                    {
                    }
                    column(Type; Type)
                    {
                    }
                    column(FANo; No)
                    {
                    }
                    column(FADescription; Description)
                    {
                    }
                    column(UnitPrice; "Unit Price")
                    {
                    }
                    column(Amount; Amount)
                    {
                    }
                    column(HighestBidder; HighestBidder)
                    {
                    }
                    column(Suggested; Suggested)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        BidLines.Reset();
                        BidLines.SetRange("FA Disposal Doc No.", Bids."FA Disposal Doc No.");
                        BidLines.SetRange(No, Bids.No);
                        BidLines.SetRange(Amount, "FA Disposal Line"."Highest Bid");
                        if BidLines.FindFirst() then begin
                            HighestBidder := BidLines."Staff Name";
                            BidLines.Suggested := true;
                            BidLines.Awarded := true;
                            BidLines.Modify();
                        end;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    CalcFields("Highest Bid");
                end;
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        FADisposal: Record "FA Disposal Line";
        HighestBidder: Text;
        BidLines: Record "Procurement Request Lines";
}
