<?php
declare(strict_types=1);

// BitcoinBarometer SDK utility: result_headers

class BitcoinBarometerResultHeaders
{
    public static function call(BitcoinBarometerContext $ctx): ?BitcoinBarometerResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
